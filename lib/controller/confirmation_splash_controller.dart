import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../routes/routes_name.dart';
import '../services/auth_services.dart';

class ConfirmationSplashController extends GetxController  {
  // late AnimationController animationController;
  // late Animation<double> animation;
  AuthServices authServices = AuthServices();

  static ConfirmationSplashController get find => Get.find();
  RxBool animate = false.obs;

  @override
  void onInit() {

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> confirmationSplashAnimation(BuildContext context) async {

    print("startAnimation called");
    await Future.delayed(Duration(milliseconds: 100));
    animate.value = true;
    print("Animation started");
    // await Future.delayed(Duration(milliseconds: 5000));
    print("Navigating to AuthPage");
    animate.close();

    Timer(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, RoutesName.sign_up);
    });

  }
  void splashDispose() {
    animate.close();
  }
}
