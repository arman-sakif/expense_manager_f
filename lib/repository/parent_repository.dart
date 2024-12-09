import 'package:flutter/foundation.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/outside_father_deatils_model.dart';
import '../res/app_urls.dart';

class ParentRepository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getParentUpdateApi(dynamic data)async{

    try{
      // print("hitting url parent update ${AppUrl.parentUpdateEndPoint}");
      // print("with data ${data}");
      dynamic response = await _apiServices.getPutApiResponse(AppUrl.parentUpdateEndPoint, data);
      // print ("this is the response after updating data $response");
      return response;

    }catch(e){
      throw e ;
    }
  }

  Future<dynamic> postExpenseApi(dynamic data) async {
    try {
      if(kDebugMode){
        // print ("hitting url ${AppUrl.parentEntryEndPoint}");
        // print(data);
      }

      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.expenseEntryEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<OutsideFatherDetailsModel> getOutsideFatherDetailsApi(String userId, String parentId,String AdditionalUrl) async {
    try {
      // print("Htting_pet_detalis_get_api_where_UserID=${userId};ParentID=$parentId$AdditionalUrl");
      // print("${AppUrl.parentDetailsEndPoint}?user_id=$userId&parent_id=$parentId$AdditionalUrl");
      final response = await _apiServices.getGetApiResponse("${AppUrl.parentDetailsEndPoint}?user_id=$userId&parent_id=$parentId$AdditionalUrl");
      // print(response);
      return OutsideFatherDetailsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postOutsideFatherEntryApi(dynamic data) async {
    try {
      print("in the repo parent entry");
      print ("hitting url ${AppUrl.outsideFatherEntryEndPoint}");
      print ("with data");
      print(data);

      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.outsideFatherEntryEndPoint, data);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }

}