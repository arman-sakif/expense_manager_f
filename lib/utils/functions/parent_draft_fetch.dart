import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../controller/page_value_controller.dart';
import '../../controller/expense_details_controller.dart';
import '../../models/user_model.dart';
import '../../res/constant.dart';
import '../../routes/routes_name.dart';
import '../../view_model/parent_view_model.dart';
import '../../view_model/user_view_model.dart';
import '../utils.dart';

Future<void> parentDraftReg(BuildContext context, int pageValue, String status) async {
  // Fetch user data
  final ExpenseController addPhotoController = Get.put(ExpenseController());
  final PageValueController pageValueController = Get.put(PageValueController());

  Future<UserModel?> getUserData() => UserViewModel().getUser();


  UserModel? user = await getUserData();
  String userId = user?.body?.userId.toString() ?? "";
  // String companyId = user?.body?.companyId.toString() ?? "";

  final parentViewModel = Provider.of<ParentViewModel>(context, listen: false);

  // Your logic here
  if (status != "draft") {
    // Collect the required fields
    final requiredFields = {
      "${AppLocalizations.of(context)!.nameText}": addPhotoController.pet_name,
      "${AppLocalizations.of(context)!.type}": addPhotoController.pet_type,
      "${AppLocalizations.of(context)!.variety}": addPhotoController.pet_variety,
      "${AppLocalizations.of(context)!.color}": addPhotoController.coat_color,
      "${AppLocalizations.of(context)!.hairType}": addPhotoController.hair_type,
      "${AppLocalizations.of(context)!.gender}": addPhotoController.gender,
      "${AppLocalizations.of(context)!.selectDate}": addPhotoController.expense_date,
      "${AppLocalizations.of(context)!.microchipNumber}": addPhotoController.microchip_no,
      "${AppLocalizations.of(context)!.status}": addPhotoController.pet_status,
    };

    // Check if any required field is empty
    for (var entry in requiredFields.entries) {
      if (entry.value == null || entry.value!.isEmpty) {
        Utils.flushBarErrorMessage(
            '${entry.key} ${AppLocalizations.of(context)!.isRequired}',
            Icons.error,
            Colors.red,
            context
        );
        return; // Stop further execution
      }
    }
  }

  if (pageValue == 1) {
    addPhotoController.user_id = userId;
    // addPhotoController.shop_id = companyId;
    parentViewModel.getParentUpdateApi(context, status);

  } else if (pageValue == 0) {
    addPhotoController.user_id = userId;
    // addPhotoController.shop_id = companyId;

    pageValueController.detailsOrConfirmOverview = Constant.confirmOverviewPage;
    print("this is the genetic disease selected");
    print(addPhotoController.genetic_disease);

    Navigator.pushNamed(
      context,
      RoutesName.parent_confirm,
    );
  }
}
