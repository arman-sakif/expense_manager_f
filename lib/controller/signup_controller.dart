import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // TextEditingController instances for input fields
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  TextEditingController parkNameTextController = TextEditingController();
  TextEditingController genderController = TextEditingController(); // Added gender controller

  // String properties for input fields
  String emailTextController = "";
  String passwordTextController = "";
  String confirmPasswordTextController = "";
  String firstNameTextController = "";
  String lastNameTextController = "";

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

  // Clear all text fields
  void clearTextFields() {
    companyIdController.clear();
    companyNameController.clear();
    emailTextController = "";
    passwordTextController = "";
    confirmPasswordTextController = "";
    firstNameTextController = "";
    lastNameTextController = "";
    parkNameTextController.clear();
    genderController.clear(); // Clear gender controller
  }
}
