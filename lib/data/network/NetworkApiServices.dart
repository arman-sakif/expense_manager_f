import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../app_exceptions.dart';
import 'BaseApiServices.dart';

class NetworkApiService extends BaseApiServices {

  @override
  Future getPostApiResponse(String url , dynamic data) async{

    print(jsonEncode(data));

    dynamic responseJson ;
    try {

      Response response = await post(
          Uri.parse(url),
          headers: {
            // "Accept": "application/json",
            "Content-Type": "application/json",
          },
          body: jsonEncode(data)
      ).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    }on SocketException {

      throw FetchDataException(' No Internet Connection');
    }

    return responseJson ;
  }

  @override
  Future getGetApiResponse(String url) async {

    dynamic responseJson ;
    try {

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json"
        },
      ).timeout(const Duration(seconds: 10)
      );
      responseJson = returnResponse(response);
    }on SocketException {

      throw FetchDataException('No Internet Connection');
    }

    return responseJson;

  }

  @override
  Future<dynamic> getPutApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future<dynamic> getPostFormDataApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add text fields
      data.forEach((key, value) {
        if (value is! File && value is! List<File>) {
          request.fields[key] = value.toString();
        }
      });

      // Add the image files if available
      if (data['images'] != null && data['images'] is List<File>) {
        for (var i = 0; i < data['images'].length; i++) {
          var image = data['images'][i];
          if (image.existsSync()) {
            request.files.add(await http.MultipartFile.fromPath('file$i', image.path));
          }
        }
      }

      // Send the request
      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      responseJson = returnResponse(responseData);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }


  dynamic returnResponse (http.Response response){

    print(response.statusCode);
    // print(response.body);

    switch(response.statusCode){
      case 200:
        // print(response.body);

        dynamic responseJson = jsonDecode(response.body);
        return responseJson ;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 502:
      return {'error': 'Bad Gateway', 'message': 'Server is temporarily unavailable. Please try again later.'};

      // throw FetchDataException('Server is temporarily unavailable (Bad Gateway). Please try again later.');

      case 404:
        throw UnauthorisedException(response.body.toString());
        // throw UnauthorisedException("not found");
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 422:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      default:
        throw FetchDataException('Error accrued while communicating with server'+
            'with status code ' +response.statusCode.toString());
    }
  }

}