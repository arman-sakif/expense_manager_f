import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_urls.dart';

class AuthRepository  {

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> signupApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(AppUrl.signupEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> signInApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.signInEndPoint, data);
      print(response.toString());

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> otpVerificationApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.verificationEndPoint, data);

      return response;
    } catch (e) {
      throw e;
    }
  }


  Future<dynamic> passwordResetRequestApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.resetPasswordRequestEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
  Future<dynamic> passwordResetConfirmApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(AppUrl.resetPasswordConfirmEndPoint, data);
      return response;
    } catch (e) {
      throw e;
    }
  }


}