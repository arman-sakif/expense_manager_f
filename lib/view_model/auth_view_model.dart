import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/controller/change_password_controller.dart';
import 'package:expense_manager/controller/page_value_controller.dart';
import 'package:expense_manager/controller/signin_controller.dart';
import 'package:expense_manager/controller/signup_controller.dart';
import 'package:expense_manager/repository/notification_repository.dart';
import 'package:expense_manager/utils/popups/CustomDialog.dart';
import 'package:expense_manager/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../repository/auth_repository.dart';
import '../routes/routes_name.dart';
import '../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AuthViewModel with ChangeNotifier {
  SignUpController signUpController = Get.put(SignUpController());
  SignInController signInController = Get.put(SignInController());
  PageValueController pageValueController = Get.put(PageValueController());
  ChangePasswordController changePasswordController = Get.put(ChangePasswordController());


  final _authRepo = AuthRepository();

  Future<String?> _getToken() async {

    if(kIsWeb){
      return "";
    }else{
      await Firebase.initializeApp();
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      String? token = await messaging.getToken();
      String? _deviceToken;
      pageValueController.deviceToken = token;
      _deviceToken = token;

      return _deviceToken;
    }


  }
  //signupApi
  // Future<void> signupApi(dynamic data , BuildContext context) async {

  Future<void> signupApi( BuildContext context) async {
    Utils.showLoading(context);
    String name= "${signUpController.firstNameTextController} ${signUpController.lastNameTextController}";



    Map data = {
      "email": signUpController.emailTextController,
      "password": signUpController.passwordTextController,
      "name":name,
      "gender": signUpController.genderController.text,
    };

    // print(data);
    _authRepo.signupApi(data).then((value) {

      final String statusCode = value['statusCode'];
      // final String? message = value['body'] != null ? value['body']['message'] : null;

      if (statusCode == "200" || statusCode == "201") {
        Utils.cancelLoading(context);
        Utils.flushBarErrorMessage(AppLocalizations.of(context)!.signupSuccessfully, Icons.check, Colors.green, context);
        // signUpController.clearTextFields();
        // Navigator.pushNamed(context, RoutesName.password_settings_completeView);
          Navigator.pop(context);

          // Navigator.pushNamed(context, RoutesName.confirm_email_View);
      } else if (statusCode == "400") {
        Utils.cancelLoading(context);
        // Utils.flushBarErrorMessage(AppLocalizations.of(context)!.alreadyExists, Icons.error, Colors.red, context);
        print(AppLocalizations.of(context)!.alreadyExists);

      } else {
        Utils.cancelLoading(context);
        // Utils.flushBarErrorMessage("${AppLocalizations.of(context)!.unexpectedError} $statusCode", Icons.error, Colors.red, context);
        print("${AppLocalizations.of(context)!.unexpectedError} $statusCode");
      }
      if(kDebugMode){
      }
    }).onError((error, stackTrace) {
      Utils.cancelLoading(context);
      // Utils.flushBarErrorMessage(error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        print(error.toString());
      }
    });

  }

  Future<void> signInApi(BuildContext context) async {
    Utils.showLoading(context);


    Map data = {
      'email': signInController.emailTextController.toString(),
      'password': signInController.passwordTextController.toString(),
    };
    _authRepo.signInApi(data).then((value) async {

      final String statusCode = value['statusCode'];

      Utils.cancelLoading(context);
      if (statusCode == "200") {
        final message = AppLocalizations.of(context)?.loginSuccessfully ?? "Login successfully";
        Utils.flushBarErrorMessage(message, Icons.check, Colors.green, context);
        signInController.emailTextController="";
        signInController.passwordTextController="";
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isFirstRun', true);
        await prefs.setBool('isChildRun', true);
        final userPreference = Provider.of<UserViewModel>(context , listen: false);
        Body body = Body.fromJson(value['body']);
        userPreference.saveUser(
            UserModel(
                body:  body
            )
        );


        Navigator.pushNamedAndRemoveUntil(context, RoutesName.menu, (route) => false);
      } else if (statusCode == "403" ) {
        final message = AppLocalizations.of(context)?.adminApproval ?? "Admin approval required";
        Utils.flushBarErrorMessage(message, Icons.check, Colors.green, context);
      } else if (statusCode == "400") {
        String errorMessage = value['body']['error'];
        // var message400 = AppLocalizations.of(context)!.incorrectCredentials;
        Utils.flushBarErrorMessage(errorMessage, Icons.error, Colors.red, context);
        print("Login unsuccessful");
      } else {
        Utils.flushBarErrorMessage("Unexpected error occurred", Icons.error, Colors.red, context);
        // print("Unhandled status code: $statusCode");
      }
      // Utils.flushBarErrorMessage(AppLocalizations.of(context)!.loginSuccessfully, Icons.check,Colors.green, context);
      if(kDebugMode){
      }
    }).onError((error, stackTrace){
      Utils.cancelLoading(context);
      Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
      if(kDebugMode){
        print(error.toString());
      }

    });
  }

  Future<dynamic> otpVerificationApi(dynamic data , BuildContext context)async{
    Utils.showLoading(context);
    _authRepo.otpVerificationApi(data).then((value){

      Utils.cancelLoading(context);
      if(kDebugMode){
        // print(value.toString());
      }
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.auth, (route)=> false);
      Utils.flushBarErrorMessage(AppLocalizations.of(context)!.adminApproval, Icons.check,Colors.green, context);
    }).onError((error, stackTrace){
      Utils.cancelLoading(context);
      Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
      if(kDebugMode){
        // print(error.toString());
      }

    });

  }

  Future<void> passwordChangeRequestApi(BuildContext context) async {
    Utils.showLoading(context);

    Map data = {
      'email': changePasswordController.resetPassEmailTextController.text,


    };
    _authRepo.passwordResetRequestApi(data).then((value){
      final String statusCode = value['statusCode'];

      Utils.cancelLoading(context);
      if (statusCode == "200") {
        // final message = AppLocalizations.of(context)?.loginSuccessfully ?? "Login successfully";
        // Utils.flushBarErrorMessage(message, Icons.check, Colors.green, context);
        Navigator.pushNamed(context,RoutesName.password_settings);
        // Navigator.pop(context);
        // Navigator.pushNamedAndRemoveUntil(context, RoutesName.password_settings, (route) => false);
      } else if (statusCode == "403" ) {
        final message = AppLocalizations.of(context)!.adminApproval;
        Utils.flushBarErrorMessage(message, Icons.check, Colors.green, context);
        print("Admin approval ");
      } else if (statusCode == "400") {
        Utils.cancelLoading(context);
        var message400 = value['body']['message'];
        Utils.flushBarErrorMessage(message400, Icons.error, Colors.red, context);
        print("Incorrect Credentials");
      }
      else if (statusCode == "502") {
        var message400 = value['body']['message'];
        Utils.flushBarErrorMessage(message400, Icons.error, Colors.red, context);
        print("Incorrect Credentials");
      }else {
        Utils.cancelLoading(context);
        Utils.flushBarErrorMessage("Unexpected error occurred", Icons.error, Colors.red, context);
        print("Unhandled status code: $statusCode");
      }
      if(kDebugMode){
      }
    }).onError((error, stackTrace){
      Utils.cancelLoading(context);
      Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }



  Future<void> passwordChangeConfirmApi(BuildContext context) async {
    Utils.showLoading(context);

    Map data = {
      "email":changePasswordController.resetPassEmailTextController.text,
      "confirmation_code":changePasswordController.otpResetPasswordTextController.text,
      "new_password": changePasswordController.newResetPasswordTextController.text,
    };

    _authRepo.passwordResetConfirmApi(data).then((value){
      final String statusCode = value['statusCode'];

      Utils.cancelLoading(context);
      if (statusCode == "200") {

        // Navigator.pushNamed(context,RoutesName.sign_in);
        // Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.sign_in, (route) => false);
      } else if (statusCode == "403" ) {
        final message = AppLocalizations.of(context)!.adminApproval;
        Utils.flushBarErrorMessage(message, Icons.check, Colors.green, context);
        print("Admin approval ");
      } else if (statusCode == "400") {
        var message400 = AppLocalizations.of(context)!.validEmailAddress;
        Utils.flushBarErrorMessage(message400, Icons.error, Colors.red, context);
        print("Incorrect Credentials");
      } else {
        Utils.flushBarErrorMessage("Unexpected error occurred", Icons.error, Colors.red, context);
        print("Unhandled status code: $statusCode");
      }
      if(kDebugMode){
      }
    }).onError((error, stackTrace){
      Utils.cancelLoading(context);
      Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}