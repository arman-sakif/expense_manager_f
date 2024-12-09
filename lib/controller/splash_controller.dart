import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../routes/routes_name.dart';
import '../services/auth_services.dart';



class SplashController extends GetxController  {
  // late AnimationController animationController;
  // late Animation<double> animation;
  AuthServices authServices = AuthServices();

  static SplashController get find => Get.find();
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

  Future<void> splashAnimation(BuildContext context) async {

    // animationController =
    //     AnimationController(
    //         vsync: stp, duration: const Duration(milliseconds: 2000));
    // animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    // animationController.forward();
    // Timer(const Duration(seconds: 3), () {
    //   print("Splash check 1");
    //   // Navigator.pushNamed(context, RoutesName.onboarding);
    //   Navigator.pushNamed(context, RoutesName.login);
    // });
    // print("Splash check 2");

    // print("startAnimation called");
    await Future.delayed(Duration(milliseconds: 5000));
    animate.value = true;
    // print("Animation started");
    // await Future.delayed(Duration(milliseconds: 5000));
    // print("Navigating to AuthPage");
    animate.close();

    Timer(const Duration(seconds: 3), () {
      authServices.checkAuthentication(context);
      // Navigator.pushNamed(context, RoutesName.onboarding);
      // Navigator.pushNamed(context, RoutesName.sign_in);
    });

    // Get.to(() => AuthPage());
    // Navigator.popAndPushNamed(
    //     context,
    //     RoutesName.auth
    // );

  }

  // void splashDispose(){
  //   // animationController.dispose();
  // }



  // Future<void> startAnimation() async {
  //   print("startAnimation called");
  //   await Future.delayed(Duration(milliseconds: 5000));
  //   animate.value = true;
  //   print("Animation started");
  //   await Future.delayed(Duration(milliseconds: 5000));
  //   print("Navigating to AuthPage");
  //   Get.to(() => AuthPage());
  // }

  void splashDispose() {
    animate.close();
  }
}
