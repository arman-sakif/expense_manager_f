import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:expense_manager/view_model/user_view_model.dart';
import '../controller/page_value_controller.dart';
import '../controller/userid_controller.dart';
import '../models/child_deatils_model.dart';
import '../models/user_model.dart';
import '../repository/child_details_repository.dart';
import '../routes/routes_name.dart';
import '../utils/utils.dart';




class ChildDetailsViewModel with ChangeNotifier {
  final _myRepo = ChildDetailsRepository();
  ChildDetailsModel? childDetails;
  late Future<ChildDetailsModel?> childDetailsFuture;
  PageValueController pageValueController = Get.put(PageValueController());
  UserIdController userIdController = Get.put(UserIdController());

  Future<UserModel?> getUserData() => UserViewModel().getUser();

  Future<void> childDetailsApi(BuildContext context, String childId, String AdditionalUrl) async {
    try {

      UserModel? user = await getUserData();
      String userId = user?.body?.userId.toString() ?? "";
      // if(parentId.isEmpty){
      //   pageValueController.parent_user_id=userId;
      // }
      childDetails = await _myRepo.getChildDetailsApi(pageValueController.child_user_id, childId,AdditionalUrl);
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
  Future<void> childSearchDetailsApi(BuildContext context, String childId, String AdditionalUrl) async {
    try {
      childDetails = await _myRepo.getChildDetailsApi(pageValueController.child_user_id, childId,AdditionalUrl);
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }

  Future<ChildDetailsModel?> fetchChildDetails(BuildContext context,
      String childId,String childUserId, String AdditionalUrl) async {

    // if(childUserId == "0"){
      await childDetailsApi(context, childId,AdditionalUrl);
      return childDetails;
    // }
    // else{
    //   await childSearchDetailsApi(context, childId,AdditionalUrl);
    //   pageValueController.child_user_id="0";
    //   return childDetails;
    // }

  }

  Future<void> getViewGrowthSearchApi(BuildContext context, String additionUrl,
      String birthId) async {
    Utils.showLoading(context);
    // UserModel? user = await getUserData();
    // String userId = user?.body?.userId.toString() ?? "";

    _myRepo.getViewGrowthSearchApi(birthId, additionUrl).then((value) {
      Utils.cancelLoading(context);
      // print("child_details_view_model ${value}");
      // final String? StatusCode = value['body']!= null ? value['body']['statusCode']: null;
      // print(StatusCode.toString());
      final String? StatusCode = value['statusCode']!= null ? value['statusCode']: null;
      // print(StatusCode.toString());
      if(StatusCode=="200"){
        final String? childId = value['body']!= null ? value['body'] ['pk_child_id'] : null;
        // print("Child_id $childId");
        final String? childUserId = value['body']!= null ? value['body'] ['sk_user_id'] : null;

        userIdController.childId = childId.toString();
        // pageValueController.growthPageValue =0;
        pageValueController.child_user_id =childUserId.toString();
        pageValueController.childButtonVisible = true;
        // Navigator.pushNamed(context, RoutesName.viewGrowthDetails);
      }
      else{
        Utils.flushBarErrorMessage(
            "Pet not found", Icons.error, Colors.red, context);
      }

      // print("child_details_view_model ${value.body.child.pkChildId}");
      // Utils.flushBarErrorMessage(AppLocalizations.of(context)!.loginSuccessfully, Icons.check,Colors.green, context);
      if (kDebugMode) {
        print(value.toString());
      }
      // Navigator.pushNamed(context, RoutesName.pet_details);
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

// Utils.showLoading(context);
// UserModel? user = await getUserData();
// String userId = user?.body?.userId.toString() ?? "";
//
// print("userIdController $userId ${ userIdController.parentId}");
//
// _myRepo.getParentDetailsApi(userId, userIdController.parentId).then((value){
//
//   Utils.cancelLoading(context);
//   // Utils.flushBarErrorMessage(AppLocalizations.of(context)!.loginSuccessfully, Icons.check,Colors.green, context);
//   if(kDebugMode){
//     print(value.toString());
//   }
//   Navigator.pushNamed(context, RoutesName.pet_details);
// }).onError((error, stackTrace){
//   Utils.cancelLoading(context);
//   Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
//   if(kDebugMode){
//     print(error.toString());
//   }
//
// });
