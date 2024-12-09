
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/profile_model.dart';
import '../res/app_urls.dart';
import 'package:http/http.dart' as http;


class ProfileRepository{
  BaseApiServices _apiServices = NetworkApiService();


  Future<ProfileModel> getProfileDetailsApi(String userId) async {
    try {
      // print("UserID=${userId}");
      final response = await _apiServices.getGetApiResponse("${AppUrl.userDetailsEndPoint}?user_id=$userId");
      // print(response);
      // print("additionUrl11 ${AppUrl.parentListEndPoint}?user_id=$userId");

      return ProfileModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> updateProfileApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPutApiResponse(AppUrl.userUpdateEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> changePasswordApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.changePasswordEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

}
