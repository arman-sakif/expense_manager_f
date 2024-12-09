import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/view_model/user_view_model.dart';
import '../data/response/api_response.dart';
import '../models/child_list_models.dart';
import '../models/user_model.dart';
import '../repository/child_list_repository.dart';
import '../repository/parent_list_repository.dart';
import '../utils/utils.dart';

class ChildListViewModel with ChangeNotifier {

  final _myRepo = ChildListRepository();


  ApiResponse<ChildListModel> childList = ApiResponse.loading();


  setChildList(ApiResponse<ChildListModel> response){
    childList = response ;
    notifyListeners();
  }
  Future<UserModel?> getUserData() => UserViewModel().getUser();


  Future<void> getChildApi(BuildContext context, String additionUrl)async{

    if (kDebugMode) {
      // print("additionUrl7 $additionUrl");
    }
    setChildList(ApiResponse.loading());

    UserModel? user = await getUserData();
    String userId = user?.body?.userId.toString() ?? "";
    // String companyId = user?.body?.companyId.toString() ?? "";
    // Utils.showLoading(context);

    // _myRepo.getChildApi(userId, additionUrl).then((value){
    _myRepo.getChildApi(userId, additionUrl).then((value){
      if (kDebugMode) {
        // print("additionUrl8 $additionUrl");
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        if (kDebugMode) {
          // print("additionUrl9 $additionUrl");
          // Utils.cancelLoading(context);

          // print("additionUrl10 $additionUrl");
        }
        notifyListeners();
        setChildList(ApiResponse.completed(value));

        if (kDebugMode) {
          // print("${value.body.length}");
        }
      });
    }).onError((error, stackTrace){

      Future.delayed(const Duration(milliseconds: 500), () {

        Utils.cancelLoading(context);
        Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
        if(kDebugMode){
          print(error.toString());
        }
        // setNotificationList(ApiResponse.error(error.toString()));
      });
    });
  }
  Future<void> getViewGrowthListApi(BuildContext context, String additionUrl)async{

    if (kDebugMode) {
      // print("additionUrl7 $additionUrl");
    }
    setChildList(ApiResponse.loading());

    UserModel? user = await getUserData();
    String userId = user?.body?.userId.toString() ?? "";
    // Utils.showLoading(context);

    _myRepo.getViewGrowthListApi(userId, additionUrl).then((value){

      if (kDebugMode) {
        // print("additionUrl16 $additionUrl");
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        if (kDebugMode) {
          // print("additionUrl17 $additionUrl");
          // Utils.cancelLoading(context);

          // print("additionUrl18 $additionUrl");
        }
        notifyListeners();
        setChildList(ApiResponse.completed(value));

        if (kDebugMode) {
          // print("${value.body.length}");
        }
      });


    }).onError((error, stackTrace){

      Future.delayed(const Duration(milliseconds: 500), () {

        Utils.cancelLoading(context);
        Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
        if(kDebugMode){
          print(error.toString());
        }
        // setNotificationList(ApiResponse.error(error.toString()));
      });


    });

  }


}

