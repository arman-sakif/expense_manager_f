
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/outside_father_deatils_model.dart';
import '../models/parent_deatils_model.dart';

import '../res/app_urls.dart';

class ParentDetailsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ParentDetailsModel> getParentDetailsApi(String userId, String parentId,String AdditionalUrl) async {
    try {
      // print("Htting_pet_detalis_get_api_where_UserID=${userId};ParentID=$parentId$AdditionalUrl");
      // print("${AppUrl.parentDetailsEndPoint}?user_id=$userId&parent_id=$parentId$AdditionalUrl");
      final response = await _apiServices.getGetApiResponse("${AppUrl.parentDetailsEndPoint}?user_id=$userId&parent_id=$parentId$AdditionalUrl");
      // print("parent_details_repository1ß $response");
      return ParentDetailsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
  Future<OutsideFatherDetailsModel> getOutsideFatherDetailsApi(String userId, String parentId,String AdditionalUrl) async {
    try {
      // print("Htting_pet_detalis_get_api_where_UserID=${userId};pk_outside_father_id=$parentId$AdditionalUrl");
      // print("${AppUrl.outsideFatherDetailsEndPoint}?user_id=$userId&pk_outside_father_id=$parentId$AdditionalUrl");
      final response = await _apiServices.getGetApiResponse("${AppUrl.outsideFatherDetailsEndPoint}?user_id=$userId&pk_outside_father_id=$parentId$AdditionalUrl");
      // print(response);
      return OutsideFatherDetailsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
