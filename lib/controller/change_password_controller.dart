import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {

  TextEditingController passwordTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();


  TextEditingController resetPassEmailTextController = TextEditingController();
  TextEditingController newResetPasswordTextController = TextEditingController();
  TextEditingController confirmResetPasswordTextController = TextEditingController();
  TextEditingController otpResetPasswordTextController = TextEditingController();



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
    // Clear the controllers when the controller is disposed
    passwordTextController.dispose();
    newPasswordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.onClose();
  }

  // Method to clear all text controllers
  void clearTextFields() {
    passwordTextController.clear();
    newPasswordTextController.clear();
    confirmPasswordTextController.clear();
  }
// void increment() => count.value++;
}
