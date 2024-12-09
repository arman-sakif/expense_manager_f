import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/controller/change_password_controller.dart';
import 'package:expense_manager/controller/page_value_controller.dart';
import 'package:expense_manager/controller/profile_controller.dart';
import 'package:expense_manager/models/profile_model.dart';
import 'package:expense_manager/repository/profile_repository.dart';
import 'package:expense_manager/routes/routes_name.dart';
import 'package:expense_manager/utils/popups/CustomDialog.dart';
import 'package:expense_manager/view_model/user_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/user_model.dart';
import '../utils/utils.dart';


class ProfileViewModel with ChangeNotifier {
  final _profileRepo = ProfileRepository();
  ProfileModel? profileDetails;
  String userId = "";
  String companyId = "";
  ProfileController profileController =
  Get.put(ProfileController());
  final changePasswordController = Get.put(ChangePasswordController());
  Future<UserModel?> getUserData() => UserViewModel().getUser();
  PageValueController pageValueController = Get.put(PageValueController());


  Future<void> profileDetailsApi(BuildContext context) async {
    try {

      UserModel? user = await getUserData();
      String userId = user?.body?.userId.toString() ?? "";
      Utils.showLoading(context);

      profileDetails = await _profileRepo.getProfileDetailsApi(userId);
      notifyListeners();
      Utils.cancelLoading(context);

    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        Utils.cancelLoading(context);
        print(error.toString());
      }
    }
  }

  Future<void> profileUpdateApi(BuildContext context) async {
    UserModel? user = await getUserData();
    userId = user?.body?.userId.toString() ?? "";
    // companyId = user?.body?.companyId.toString() ?? "";

    Utils.showLoading(context);

    Map data = {
      "pk_user_id": userId,
      // "sk_id": companyId,
      // "email": profileController.emailController.text.toString(),
      "user_name": profileController.nameController.text.toString(),

    };
    // print(data);
    _profileRepo.updateProfileApi( data).then((value){

      Utils.cancelLoading(context);

      // Utils.flushBarErrorMessage(AppLocalizations.of(context)!.uploadCompleted, Icons.check,Colors.green, context);
      if(kDebugMode){
        // print(value.toString());
      }

      if(value['statusCode'] == "200"){
        // Utils.flushBarErrorMessage(AppLocalizations.of(context)!.uploadCompleted, Icons.check,Colors.green, context);

        Navigator.pop(context,2);
      }


    }).onError((error, stackTrace){
      Utils.cancelLoading(context);
      Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
      if(kDebugMode){
        // print(error.toString());
      }
    });

  }
  Future<void> passwordChangeApi(BuildContext context) async {
    Utils.showLoading(context);
    UserModel? user = await getUserData();
    String accessToken = user?.body?.accessToken.toString() ?? "";
    Map data = {
      'old_password': changePasswordController.passwordTextController.text,
      'new_password': changePasswordController.newPasswordTextController.text,
      'access_token':accessToken,
    };
    _profileRepo.changePasswordApi(data).then((value){
      final String statusCode = value['statusCode'];

      Utils.cancelLoading(context);
      if (statusCode == "200") {
        // final message = AppLocalizations.of(context)?.loginSuccessfully ?? "Login successfully";
        // Utils.flushBarErrorMessage(message, Icons.check, Colors.green, context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: AppLocalizations.of(context)!.passwordChanged,
              buttonText: AppLocalizations.of(context)!.close,
              onPressed: () {
                changePasswordController.clearTextFields();
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          },
        );

        // Navigator.pop(context);

        // Navigator.pushNamedAndRemoveUntil(context, RoutesName.menu, (route) => false);
      } else if (statusCode == "403" ) {
        final message = AppLocalizations.of(context)?.adminApproval ?? "Admin approval required";
        Utils.flushBarErrorMessage(message, Icons.check, Colors.green, context);
        print("Admin approval ");
      } else if (statusCode == "400") {
        var message400 = AppLocalizations.of(context)!.incorrectCredentials;
        Utils.flushBarErrorMessage(message400, Icons.error, Colors.red, context);
        print("Incorrect password");
      } else {
        Utils.flushBarErrorMessage("Unexpected error occurred", Icons.error, Colors.red, context);
        print("Unhandled status code: $statusCode");
      }

      // Utils.flushBarErrorMessage(AppLocalizations.of(context)!.uploadCompleted, Icons.check,Colors.green, context);
      if(kDebugMode){
        print(value.toString());
      }

      // Future.delayed(const Duration(milliseconds: 1000), () {
      //   Navigator.pop(context);
      //   Navigator.pop(context,1);
      // });


    }).onError((error, stackTrace){
      Utils.cancelLoading(context);
      Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
      if(kDebugMode){
        print(error.toString());
      }

    });


  }


}
