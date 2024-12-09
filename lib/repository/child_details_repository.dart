import 'package:flutter/foundation.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/child_deatils_model.dart';
import '../models/parent_deatils_model.dart';

import '../res/app_urls.dart';

class ChildDetailsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ChildDetailsModel> getChildDetailsApi(String userId, String childId, String AdditionalUrl) async {
    try {
      if(kDebugMode){
        // print("UserID=${userId}");
        // print(AdditionalUrl);
        // print("hitting child detailsapi with: ${AppUrl.growthDetailsEndPoint}?user_id=$userId&child_id=$childId$AdditionalUrl");

      }
           final response = await _apiServices.getGetApiResponse("${AppUrl.growthDetailsEndPoint}?user_id=$userId&child_id=$childId$AdditionalUrl");

      if(kDebugMode) {
        // print("child_details_repository1ß $response");
      }
      return ChildDetailsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> getViewGrowthSearchApi(String birth_id, String additionUrl)async{

    try{
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.viewGrowthSearchEndPoint}?birth_id=$birth_id$additionUrl");
      print("additionUrl14 ${AppUrl.viewGrowthSearchEndPoint}?birth_id=$birth_id$additionUrl");
      // print(response);
      // return response = ChildDetailsModel.fromJson(response) ;
      return response ;

    }catch(e){
      throw e ;
    }
  }
}
