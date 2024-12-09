import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
import 'image_functions.dart';


Future<void> parentEntry(BuildContext context) async {
  final parentDetailsController = Get.put(ExpenseController());

  Future<UserModel?> getUserData() => UserViewModel().getUser();

  UserModel? user = await getUserData();
  String userId = user?.body?.userId.toString() ?? "";

  try {

      final parentViewModel = Provider.of<ParentViewModel>(context, listen: false);

        print("tring to do draft reg");
        parentDetailsController.user_id = userId;
        // parentDetailsController.shop_id = companyId;
        parentViewModel.postExpenseEntryApi(context);


  } catch (e) {
    print('Error: $e');
  }
}
