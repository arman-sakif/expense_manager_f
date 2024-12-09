import 'package:get/get.dart';

import '../models/child_deatils_model.dart';
class PageValueController extends GetxController {

  late int pageValue;

  late bool isVisible;
  late int addPhotoPageValue;
  late int singlePhotoPageValue;//for add_single_photo_view screen
  late int detailsOrConfirmOverview;
  late int growthDetailsPageValue;
  late int parentDetailsPageValue;
  late int registrationPageValue;
  late bool childButtonVisible;
  String child_user_id = "0";
  String parent_user_id = "0";
  String? deviceToken = "";
  late bool listCardColor;

  late int draftPageValue=0;
  late int draftChildPageValue=0;
  late int pedigreeFormPageValue=0;


  int parentPageValue = 0;
  int displayItems =10;
  int displayChildItems =10;
  late String pet_parent_gender;
  late String pet_parent_status;
  late String pet_parent_type;


  late String mother_id;
  late String mother_name;
  late String mother_type;
  late String mother_variety;
  late String mother_gender;
  late String mother_weight;
  late String mother_birth_date;
  late String mother_status;
  late String mother_group;
  late String mother_image_path;
  late String mother_control_number;
  late String mother_children_number;

  late String father_id;
  late String father_name;
  late String father_type;
  late String father_variety;
  late String father_gender;
  late String father_weight;
  late String father_birth_date;
  late String father_status;
  late String father_type_status;
  late String father_group;
  late String father_image_path;
  late String father_control_number;
  late String father_children_number;

  bool filters = true;
  bool filterParent = true;

  late int selectedIndex = 0;

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

  void clearMotherInfo() {
    mother_id = '';
    mother_name = '';
    mother_type = '';
    mother_variety = '';
    mother_gender = '';
    mother_weight = '';
    mother_birth_date = '';
    mother_status = '';
    mother_group = '';
    mother_image_path = '';
    mother_control_number = '';
    mother_children_number = '';
  }

  void clearFatherInfo() {
    father_id = '';
    father_name = '';
    father_type = '';
    father_variety = '';
    father_gender = '';
    father_weight = '';
    father_birth_date = '';
    father_status = '';
    father_group = '';
    father_image_path = '';
    father_control_number = '';
    father_children_number = '';
  }
  void clearFatherData() {
    father_id = '';
    father_name = '';
    father_type = '';
    father_variety = '';
    father_gender = '';
    father_weight = '';
    father_birth_date = '';
    father_status = '';
    father_group = '';
    father_image_path = '';
    father_control_number = '';
    father_children_number = '';
  }
  void addMotherInfo(Ther mother) {
    mother_id = mother.pkParentId;
    mother_name = mother.petName;
    mother_type = mother.petType;
    mother_variety = mother.petVariety;
    mother_gender = mother.gender;
    mother_weight = mother.petWeight;
    mother_birth_date = mother.birthDate;
    mother_status = mother.petStatus;
    mother_group = mother.managementNumber;
    mother_image_path = mother.images.path1 ?? '';
    mother_control_number = mother.managementNumber;
    mother_children_number = mother.parentChildren;
  }

  void addFatherInfo(Ther father) {
    father_id = father.pkParentId;
    father_name = father.petName;
    father_type = father.petType;
    father_variety = father.petVariety;
    father_gender = father.gender;
    father_weight = father.petWeight;
    father_birth_date = father.birthDate;
    father_status = father.petStatus;
    father_group = father.managementNumber;
    father_image_path = father.images.path1 ?? '';
    father_control_number = father.managementNumber;
    father_children_number = father.parentChildren;
  }


}