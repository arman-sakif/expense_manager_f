import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/controller/page_value_controller.dart';
import 'package:expense_manager/models/outside_father_deatils_model.dart';
import 'package:expense_manager/view_model/user_view_model.dart';

import '../models/parent_deatils_model.dart';
import '../models/user_model.dart';
import '../repository/parent_details_repository.dart';
import '../utils/utils.dart';

class ParentDetailsViewModel with ChangeNotifier {
  final _myRepo = ParentDetailsRepository();
  ParentDetailsModel? parentDetails;
  OutsideFatherDetailsModel? outsideFatherDetails;
  late Future<ParentDetailsModel?> parentDetailsFuture;
  PageValueController pageValueController = Get.put(PageValueController());

  Future<UserModel?> getUserData() => UserViewModel().getUser();

  Future<void> parentDetailsApi(BuildContext context, String parentId,String AdditionalUrl) async {
    try {
      UserModel? user = await getUserData();
      String userId = user?.body?.userId.toString() ?? "";

      // parentDetails = await _myRepo.getParentDetailsApi(userId, parentId,AdditionalUrl);
      // print("______");
      // print(pageValueController.parent_user_id);
      // print(parentId);
      // print("______");

      if(parentId.isEmpty){
        pageValueController.parent_user_id=userId;
      }
      parentDetails = await _myRepo.getParentDetailsApi(pageValueController.parent_user_id, parentId,AdditionalUrl);
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<ParentDetailsModel?> fetchParentDetails(BuildContext context, String parentId, String AdditionalUrl) async {
    await parentDetailsApi(context, parentId,AdditionalUrl);
    return parentDetails;
  }

  Future<void> outsideFatherDetailsApi(BuildContext context, String parentId,String AdditionalUrl) async {
    try {

      // UserModel? user = await getUserData();
      // String userId = user?.body?.userId.toString() ?? "";
      // print("______");
      // print(pageValueController.parent_user_id);
      outsideFatherDetails = await _myRepo.getOutsideFatherDetailsApi(pageValueController.parent_user_id, parentId,AdditionalUrl);
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<OutsideFatherDetailsModel?> fetchOutsideFatherDetails(BuildContext context, String parentId, String AdditionalUrl) async {
    await outsideFatherDetailsApi(context, parentId,AdditionalUrl);
    return outsideFatherDetails;
  }


}
