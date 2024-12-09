import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PetVarietyController extends GetxController {


  String selectedOwnershipType = "";
  int? selectedOwnerType;
  late String dateOfOwnership = " ";

  // Data Lists
  List<Map<String, String>> selectedDiseasesAndResults = [];
  List<String> dogVarietyList = [];
  List<String> catVarietyList = [];
  List<String> dogHairData = [];
  List<String> catHairData = [];
  List<String> dogCoatData = [];
  List<String> catCoatData = [];
  List<String> catPedigreeGroup = [];
  List<String> dogPedigreeGroup = [];
  List<String> diseaseResult = [];
  List<String> catDisease = [];
  List<String> dogDisease = [];

  List<String> allVarietyList = [
    'シャム',
    'シャム2',
  ];

  // User Data
  String userId = "";
  String parentTypeValue = "";
  String parentVarietyValue = "";
  String parentGenderValue = "";
  String parentStatusValue = "";




  void clearAll() {
    // Clear the text controllers



    // Clear the saved state map
  }




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



}