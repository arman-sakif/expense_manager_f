import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../controller/change_password_controller.dart';
import '../../res/app_color.dart';
import '../../utils/common_header.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/rounded_text_input_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/utils.dart';
import '../../view_model/profile_view_model.dart';

class ProfilePasswordEditPage extends StatefulWidget {
  @override
  State<ProfilePasswordEditPage> createState() =>
      _ProfilePasswordEditPageState();
}

class _ProfilePasswordEditPageState extends State<ProfilePasswordEditPage> {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  // Future<UserModel?> getUserData() => UserViewModel().getUser();

  String accessToken="";
  get fontSize => null;

  @override
  void initState() {
    super.initState();

    // fetchUserToken();
  }
  // Future<void> fetchUserToken() async {
  //
  //   UserModel? user = await getUserData();
  //   accessToken = user?.body?.accessToken.toString() ?? "";
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    double fontSize;
    if (screenWidth < 360) {
      fontSize = 14; // Small screens
    } else if (screenWidth < 720) {
      fontSize = 17; // Medium screens
    } else {
      fontSize = 20; // Large screens
    }
    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonHeader(title: AppLocalizations.of(context)!.changePassword,
            onBackPress: (){
              changePasswordController.clearTextFields();
              Navigator.pop(context);
            }
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(AppLocalizations.of(context)!.passwordText,
                  style: TextStyle(
                    fontSize: fontSize,
                  )),
            ),
            profileCard(context)
          ],
        ),
      ),
    );
  }

  Widget profileCard(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    return Container(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 9, left: 9, bottom: 9),
              child: Text(AppLocalizations.of(context)!.currentPassword,
                  style: TextStyle(
                    fontSize: fontSize,
                  )),
            ),
            RoundedTextInputField(
              name: AppLocalizations.of(context)!.enterPassword,
              textEditingController:
                  changePasswordController.passwordTextController,
              // onChanged: (value) {
              //   changePasswordController.passwordTextController.text = value;
              //   setState(() {});
              // },
              // onSubmitted: (value){
              //   changePasswordController.passwordTextController.text = value;
              // },
              isPassword: true,
            ),
            SizedBox(
              height: 5,
            ),
            customDivider(),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 9, bottom: 9),
              child: Text(AppLocalizations.of(context)!.newPassword,
                  style: TextStyle(
                    fontSize: fontSize,
                  )),
            ),
            RoundedTextInputField(
              name: AppLocalizations.of(context)!.enterPassword,
              textEditingController:
                  changePasswordController.newPasswordTextController,
              // onChanged: (value) {
              //   changePasswordController.newPasswordTextController.text = value;
              //   setState(() {});
              // },
              // onSubmitted: (value){
              //   changePasswordController.newPasswordTextController.text = value;
              // },
              isPassword: true,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 9, left: 9, bottom: 9),
              child: Text(AppLocalizations.of(context)!.newPasswordConfirm,
                  style: TextStyle(
                    fontSize: fontSize,
                  )),
            ),
            RoundedTextInputField(
              name: AppLocalizations.of(context)!.confirmPasswordText,
              textEditingController:
                  changePasswordController.confirmPasswordTextController,
              // onChanged: (value) {
              //   changePasswordController.confirmPasswordTextController.text = value;
              //   setState(() {});
              // },
              // onSubmitted: (value){
              //   changePasswordController.confirmPasswordTextController.text = value;
              // },
              isPassword: true,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: size.height * 0.08),
              child: CustomButton(
                text: AppLocalizations.of(context)!.change,
                onPressed: () {
                  if (changePasswordController.newPasswordTextController.text.isEmpty ||
                      changePasswordController.confirmPasswordTextController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        AppLocalizations.of(context)!.requiredFields,
                        Icons.error,
                        Colors.red,
                        context);
                  } else if (changePasswordController
                      .newPasswordTextController.text.length <
                      6) {
                    Utils.flushBarErrorMessage(
                        AppLocalizations.of(context)!
                            .atLeastSixCharacters,
                        Icons.error,
                        Colors.red,
                        context);
                  } else if (changePasswordController.newPasswordTextController.text!=changePasswordController.confirmPasswordTextController.text) {
                    Utils.flushBarErrorMessage(
                        AppLocalizations.of(context)!
                            .passwordsNotMatch,
                        Icons.error,
                        Colors.red,
                        context);
                  }else {

                    // profileViewModel.passwordChangeApi( context);

                  }
                  // _showDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}
