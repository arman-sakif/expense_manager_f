import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {

  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  TextEditingController userCompanyNameController = TextEditingController();
  TextEditingController parkNameController = TextEditingController();
  String parkNameText = "";
  // String genderStatus = "0";
  // String typeStatus = "0";

  TextEditingController companyNameController = TextEditingController();
  TextEditingController groupIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  TextEditingController representativeNameController = TextEditingController();
  TextEditingController createdAtController = TextEditingController();
  TextEditingController updatedAtController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

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

// void increment() => count.value++;
}
