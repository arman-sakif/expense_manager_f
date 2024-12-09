import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:expense_manager/controller/outside_father_details_controller.dart';
import 'package:expense_manager/controller/page_value_controller.dart';
import 'package:expense_manager/models/outside_father_deatils_model.dart';
import 'package:expense_manager/models/user_model.dart';
import 'package:expense_manager/repository/parent_repository.dart';
import 'package:expense_manager/res/constant.dart';
import 'package:expense_manager/view_model/user_view_model.dart';
import '../controller/expense_details_controller.dart';
import '../routes/routes_name.dart';
import '../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ParentViewModel with ChangeNotifier {
  final _myRepo = ParentRepository();
  PageValueController pageValueController = Get.put(PageValueController());
  Future<UserModel?> getUserData() => UserViewModel().getUser();
  OutsideFatherDetailsModel? outsideParentDetails;

  Future<void> getParentUpdateApi(BuildContext context, String status, {Map<String, dynamic>? retireInfo}) async {
    Utils.showLoading(context);

    final ExpenseController parentDetailsController = Get.find<ExpenseController>();

    // Declare the data map
    Map<String, dynamic> data;

    // Assign data based on the status and retireInfo
    if (status == "retire" && retireInfo != null) {
      data = retireInfo;
    } else {
      // Map the data from the controller
      data = {
        "user_id": parentDetailsController.user_id,
        "parent_id": parentDetailsController.parent_id,
        "shop_id": parentDetailsController.shop_id,
        "birth_date": parentDetailsController.expense_date,
        "gender": parentDetailsController.gender,
        "microchip_no": parentDetailsController.microchip_no,
        "pedigree_grp": parentDetailsController.pedigree_grp,
        "pet_desc": parentDetailsController.pet_desc,
        "pet_type": parentDetailsController.pet_type,
        "pet_status": parentDetailsController.pet_status,
        "pet_weight": parentDetailsController.pet_weight,
        "pet_name": parentDetailsController.pet_name,
        "pet_variety": parentDetailsController.pet_variety,
        "images": parentDetailsController.images,
        "coat_color": parentDetailsController.coat_color,
        "hair_type": parentDetailsController.hair_type,
        "pedigree_number": parentDetailsController.pedigree_number,
        "genetic_disease": parentDetailsController.genetic_disease,
        "parent_delete_flag": status == "draft" ? "2" : "0",
      };
    }

    try {
      // print("tring to hit paretn update api");
      // print("updating data");
      // print(data);
      final value = await _myRepo.getParentUpdateApi(data);
      Utils.cancelLoading(context);

      if (kDebugMode) {
        // print(value.toString());
      }

      if (value['statusCode'] == "200") {
        if (status == "retire") {
          Utils.flushBarErrorMessage(
            "${AppLocalizations.of(context)!.successfully_retired}",
            Icons.check,
            Colors.green,
            context,
          );
          await Future.delayed(Duration(seconds: 2));
        }

        Navigator.pushNamedAndRemoveUntil(context, RoutesName.menu, (route) => false);

        // Clear the controller values after successful submission
        // print("clearing from controller");
        parentDetailsController.clearAllValues();
      }
    } catch (error) {
      Utils.cancelLoading(context);
      Utils.flushBarErrorMessage(
          error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }


  Future<void> postExpenseEntryApi(BuildContext context) async {
    // Access the controller
    final ExpenseController expenseDetailsController =
        Get.find<ExpenseController>();

    // Map the data from the controller
    Map<String, dynamic> data = {
      "user_id": expenseDetailsController.user_id.toString(),
      "expense_amount": expenseDetailsController.expense_amount.text,
      "product_name": expenseDetailsController.product_name.text,
      "time_of_use": expenseDetailsController.expense_date, // Assuming expense_date is used for the time of use
    };



    print(data);
    Utils.showLoading(context);
    _myRepo.postExpenseApi(data).then((value) {
      Utils.cancelLoading(context);
      if (kDebugMode) {
        // print(value.toString());
      }

      if (value['statusCode'] == "200") {
        Navigator.pushNamedAndRemoveUntil(
            context, RoutesName.menu, (route) => false);

        // Clear the controller values after successful submission
        expenseDetailsController.clearAllValues();
      }
    }).onError((error, stackTrace) {
      Utils.cancelLoading(context);
      Utils.flushBarErrorMessage(
          error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


}
