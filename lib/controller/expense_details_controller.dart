import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/parent_deatils_model.dart';


class ExpenseController extends GetxController {


  // Initialize fields with safe defaults or make them nullable
  List<dynamic> combinedParentImageFiles = [];
  List<XFile> parentXFiles = [];
  List<String?> past_imageUrls = [];
  Map data = {};
  var showGeneticDiseaseInput = false.obs;

  // TextEditingControllers
  final TextEditingController product_name = TextEditingController();
  final TextEditingController expense_amount = TextEditingController();
  final TextEditingController microchipNumberController = TextEditingController();
  final TextEditingController aboutPetController = TextEditingController();
  final TextEditingController pedigreeNumberController = TextEditingController();
  final TextEditingController inputGeneticDiseaseController = TextEditingController();


  ///pedgree owner information text editing controller
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerAddressController = TextEditingController();
  final TextEditingController ownerPostCodeController = TextEditingController();
  final TextEditingController   animalBusinessHandlerController = TextEditingController();

  String? user_id;
  String? parent_id;
  String? shop_id;
  String? expense_date;
  // 2 new pedigree fields
  String? ownership_date;
  String? ownership_type;
  String? gender;
  String? microchip_no;
  String? management_number;
  String? pedigree_grp;
  String? pet_desc;
  String? parent_delete_flag;
  String? pet_type;
  String? pet_status;
  String? pet_weight;
  String? pet_name;
  String? pet_variety;
  String? coat_color;
  String? hair_type;
  String? pedigree_number;
  Map<String, String> genetic_disease = {};
  Map<String, dynamic> images = {};
  String? domicile;
  // String? supplier_type;


  List<String> dog_pedigree_list = [];
  List<String> cat_pedigree_list = [];
  String? selectedPedigreeGroupController;
  String? parentTypeValueController;

  late ParentDetailsModel parentDetailsModel;

  // Store the state of Page 2
  Map<String, dynamic> parentEntryState = {};

  // Method to save the current state of Page 2
  void saveParentEntryState() {
    parentEntryState['firstName'] = product_name.text;
    parentEntryState['weight'] = expense_amount.text;
    parentEntryState['variety'] = pet_variety;
    parentEntryState['coatColor'] = coat_color;
    parentEntryState['hairType'] = hair_type;
    parentEntryState['pedigreeGroup'] = pedigree_grp;
    parentEntryState['gender'] = gender;
    parentEntryState['petType'] = pet_type;
    parentEntryState['petStatus'] = pet_status;
    parentEntryState['microchipNumber'] = microchipNumberController.text;
    parentEntryState['birthDate'] = expense_date;
    parentEntryState['petDesc'] = aboutPetController.text;
    parentEntryState['pedigreeNumber'] = pedigreeNumberController.text;

    /// pedigree info backup create

    parentEntryState['ownershipType'] = ownership_type;
    parentEntryState['ownershipDate'] = ownership_date;
    parentEntryState['ownerName'] = ownerNameController.text;
    parentEntryState['ownerAddress'] = ownerAddressController.text;
    parentEntryState['ownerPostCode'] = ownerPostCodeController.text;
    parentEntryState['animalBusinessHandler'] = animalBusinessHandlerController.text;


  }

  // Method to check if the state exists
  bool hasParentEntryState() {
    return parentEntryState.isNotEmpty;
  }

  // Method to restore the saved state
  void restoreParentEntryState() {
    product_name.text = parentEntryState['firstName'] ?? "";
    expense_amount.text = parentEntryState['weight'] ?? "";
    microchipNumberController.text = parentEntryState['microchipNumber'] ?? "";
    aboutPetController.text = parentEntryState['petDesc'] ?? "";
    pedigreeNumberController.text = parentEntryState['pedigreeNumber'] ?? "";
    pet_variety = parentEntryState['variety'] ?? "";
    coat_color = parentEntryState['coatColor'] ?? "";
    hair_type = parentEntryState['hairType'] ?? "";
    pedigree_grp = parentEntryState['pedigreeGroup'] ?? "";


    /// pedigree info backup fetch
    ownerNameController.text = parentEntryState['ownerName'] ?? "";
    ownerAddressController.text = parentEntryState['ownerAddress'] ?? "";
    ownerPostCodeController.text = parentEntryState['ownerPostCode'] ?? "";
    animalBusinessHandlerController.text = parentEntryState['animalBusinessHandler'] ?? "";
    ownership_type = parentEntryState['ownershipType'] ?? "";
    ownership_date = parentEntryState['ownershipDate'] ?? "";

  }

  // function to clear the first field data in pedigree group pedigree info is recorded
  void clearPedigreeInfo() {
    pedigree_grp = "";
     selectedPedigreeGroupController ="";

    pedigreeNumberController.clear();
  }
  // function to clear the third field data in pedigree group where owner data is recorded

  void clearOwnerInfo() {
    ownership_type = "";
    ownerNameController.clear();
    ownerAddressController.clear();
    ownerPostCodeController.clear();
    animalBusinessHandlerController.clear();
    // update(); // Notify listeners if using GetX state management
  }
  // Method to clear all values and reset the controller
  void clearAllValues() {
    parentXFiles = [];
    data = {};


    product_name.clear();
    expense_amount.clear();
    microchipNumberController.clear();
    aboutPetController.clear();
    pedigreeNumberController.clear();

    user_id = null;
    shop_id = null;
    expense_date = null;
    gender = null;
    microchip_no = null;
    management_number = null;
    pedigree_grp = null;
    pet_desc = null;
    parent_delete_flag = null;
    pet_type = null;
    pet_status = null;
    pet_weight = null;
    pet_name = null;
    pet_variety = null;
    coat_color = null;
    hair_type = null;
    pedigree_number = null;
    genetic_disease = {};
    images = {};
    domicile = null;
    parentEntryState.clear();
    ///clear pedigree info
    ownerNameController.clear();
    ownerAddressController.clear();
    ownerPostCodeController.clear();
    animalBusinessHandlerController.clear();
    ownership_date=null;
    ownership_type=null;


  }

  // Method to populate the controller's fields with the model's data
  void populateFromModel(ParentDetailsModel model) {
    final Body? body = model.body;

    if (body != null) {

      user_id = body.skUserId;
      parent_id = body.pkParentId;
      shop_id = body.shopId;
      expense_date = body.birthDate;
      gender = body.gender;
      microchip_no = body.microchipNo;
      management_number = body.managementNumber;
      pedigree_grp = body.pedigreeGrp;
      pet_desc = body.petDesc;
      parent_delete_flag = body.parentDeleteFlag;
      pet_type = body.petType;
      pet_status = body.petStatus;
      pet_weight = body.petWeight;
      pet_name = body.petName;
      pet_variety = body.petVariety;
      coat_color = body.coatColor;
      hair_type = body.hairType;
      pedigree_number = body.pedigreeNumber;
      genetic_disease = body.geneticDisease ?? {};
      images = {
        'path1': body.images?.path1,
        'path2': body.images?.path2,
        'path3': body.images?.path3,
      };

      // Populate TextEditingControllers
      product_name.text = pet_name ?? "";
      expense_amount.text = pet_weight ?? "";
      microchipNumberController.text = microchip_no ?? "";
      aboutPetController.text = pet_desc ?? "";
      pedigreeNumberController.text = pedigree_number ?? "";
    }
  }

  @override
  void onClose() {
    saveParentEntryState();
    super.onClose();
  }
}
