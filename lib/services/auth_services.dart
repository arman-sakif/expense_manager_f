import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../routes/routes_name.dart';
import '../view_model/user_view_model.dart';

class AuthServices {
  Future<UserModel?> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    String? _deviceToken;
    try {
      UserModel? user = await getUserData();

      if (kDebugMode) {
        // print(user?.body?.idToken.toString());
        // print(user?.body?.userId.toString());
      }



      if (user?.body?.idToken == null || user?.body?.idToken == '') {
        Navigator.pushNamed(context, RoutesName.sign_in);
        // print("onboarding print");
        // Navigator.pushNamed(context, RoutesName.sign_in);
      } else {
        // print("direct print");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isFirstRun', true);
        await prefs.setBool('isChildRun', true);
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.menu, (route) => false);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
}