import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/view_model/user_view_model.dart';
import '../data/response/api_response.dart';
import '../models/member_list_models.dart';
import '../models/user_model.dart';
import '../repository/member_list_repository.dart';
import '../utils/utils.dart';

class MemberListViewModel with ChangeNotifier {

  final _myRepo = MemberListRepository();


  ApiResponse<MemberModel> memberList = ApiResponse.loading();

  setMemberList(ApiResponse<MemberModel> response){
    memberList = response ;
    notifyListeners();
  }
  Future<UserModel?> getUserData() => UserViewModel().getUser();


  Future<void> getMemberApi(BuildContext context, String additionUrl)async{

    // print("additionUrl7 $additionUrl");
    setMemberList(ApiResponse.loading());

    UserModel? user = await getUserData();
    String userId = user?.body?.userId.toString() ?? "";
    // String companyId = user?.body?.companyId.toString() ?? "";
    // Utils.showLoading(context);

    _myRepo.getMemberApi(userId, additionUrl).then((value){

      // print("additionUrl8 $additionUrl");

      Future.delayed(const Duration(milliseconds: 500), () {
        // print("additionUrl9 $additionUrl");
        // Utils.cancelLoading(context);

        // print("additionUrl10 $additionUrl");
        notifyListeners();
        setMemberList(ApiResponse.completed(value));

        if (kDebugMode) {
          // print("${value.body}");
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

