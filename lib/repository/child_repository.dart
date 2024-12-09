import 'package:flutter/foundation.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_urls.dart';

class ChildRepository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getChildUpdateApi(dynamic data)async{

    try{
      if(kDebugMode){
        // print("hitting url parent update ${AppUrl.petChildUpdateEndPoint}");
      }
      // print("with data ${data}");
      dynamic response = await _apiServices.getPutApiResponse(AppUrl.petChildUpdateEndPoint, data);
      // print ("this is the response after updating data $response");
      return response;

    }catch(e){
      throw e ;
    }
  }

  Future<dynamic> postChildEntryApi(dynamic data) async {
    try {
      if (kDebugMode) {
        print("in the repo parent entry");
        print("hitting url ${AppUrl.growthEntryEndPoint}");
        print("with data");
        print(data);
      }
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.growthEntryEndPoint, data);
      if (kDebugMode) {
        print(response);
      }
      return response;
    } catch (e) {
      throw e;
    }
  }

}