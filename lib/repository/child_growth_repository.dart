import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_urls.dart';

class ChildGrowthRepository {

  BaseApiServices _apiServices = NetworkApiService();


  Future<dynamic> putChildGrowthApi(dynamic data) async {
    try {
      // print("tring to hit this url for child growth update");
      // print ("url:${AppUrl.childGrowthEndPoint}");
      dynamic response =
      await _apiServices.getPutApiResponse(AppUrl.childGrowthEndPoint, data);
      // print("this is the response from the repository $response");
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> putChildGrowthEndApi(dynamic data) async {
    try {
      print("tring to hit this url for child growth update");
      print ("url:${AppUrl.childGrowthRecordedEndPoint}");
      dynamic response =
      await _apiServices.getPutApiResponse(AppUrl.childGrowthRecordedEndPoint, data);
      print("this is the response from the repository $response");
      return response;
    } catch (e) {
      throw e;
    }
  }

}