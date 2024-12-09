import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:provider/provider.dart';
import '../../controller/signup_controller.dart';
import '../../res/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/common_header.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import '../../utils/components/textComponents/round_text_bar.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class newPasswordPage extends StatefulWidget {
  const newPasswordPage({super.key});

  @override
  State<newPasswordPage> createState() => _newPasswordPageState();
}

class _newPasswordPageState extends State<newPasswordPage> {
  SignUpController signUpController = Get.put(SignUpController());


  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHeader(title: AppLocalizations.of(context)!.passwordSettings, hideBackButton: false),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05,left: screenWidth*0.08,right: screenWidth*0.08),
            child: Column(
              children: [
                CustomText(

                  text: AppLocalizations.of(context)!.loggingPassword,
                  textColor: AppColors.blackColor,
                  fontSize: 16,),
                SizedBox(height: screenHeight * 0.03),
                // Align(
                //   alignment: Alignment.topLeft,
                //
                //   child: CustomText(
                //     text: AppLocalizations.of(context)!.authenticationCode,
                //     textColor: AppColors.blackColor,
                //     fontSize: 16,
                //   ),
                // ),
                // RoundInputField(
                //   // name: AppLocalizations.of(context)!.parkNumber,
                //   name: AppLocalizations.of(context)!.authenticationCode,
                //   // textEditingController: signUpNameController,
                // ),
                // SizedBox(height: screenHeight * 0.03),
                Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      text: AppLocalizations.of(context)!.password,
                      textColor: AppColors.blackColor,
                      fontSize: 16,)),
                SizedBox(height: screenHeight * 0.005),
                RoundInputField(
                  name: AppLocalizations.of(context)!.enterPassword,
                  isPassword: true,
                  // textEditingController: signUpPasswordController,
                  onChanged: (value) {
                    signUpController.passwordTextController = value;
                    setState(() {});
                  },
                  onSubmitted: (value){
                    signUpController.passwordTextController = value;
                  },
                ),
                SizedBox(height: screenHeight * 0.01),
                Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(
                      text: AppLocalizations.of(context)!.passwordConfirm,
                      textColor: AppColors.blackColor,
                      fontSize: 16,)),
                SizedBox(height: screenHeight * 0.005),
                RoundInputField(
                  name: AppLocalizations.of(context)!.confirmPasswordText,
                  isPassword: true,
                  onChanged: (value) {
                    signUpController.confirmPasswordTextController = value;
                    setState(() {});
                  },
                  onSubmitted: (value){
                    signUpController.confirmPasswordTextController = value;
                  },
                ),

                SizedBox(height: screenHeight * 0.02),
                CustomButton(
                  text: AppLocalizations.of(context)!.register,
                  onPressed: () {
                    // Navigator.pushNamed(context,RoutesName.password_settings,);

                    if (signUpController.passwordTextController.isEmpty ||
                        signUpController.confirmPasswordTextController.isEmpty) {
                      Utils.flushBarErrorMessage(
                          AppLocalizations.of(context)!.requiredFields,
                          Icons.error,
                          Colors.red,
                          context);
                    } else if (signUpController.passwordTextController.isEmpty ||
                        signUpController.confirmPasswordTextController.isEmpty)
                    {
                      Utils.flushBarErrorMessage(
                          AppLocalizations.of(context)!.passwordConfirmPassword,
                          Icons.error,
                          Colors.red,
                          context);
                    } else if (signUpController.passwordTextController.length < 6)
                    {
                      Utils.flushBarErrorMessage(
                          AppLocalizations.of(context)!
                              .atLeastSixCharacters,
                          Icons.error,
                          Colors.red,
                          context);
                    } else if (signUpController
                        .confirmPasswordTextController !=
                        signUpController.passwordTextController) {
                      Utils.flushBarErrorMessage(
                          AppLocalizations.of(context)!
                              .passwordsNotMatch,
                          Icons.error,
                          Colors.red,
                          context);
                    } else {
                      Map data = {
                        'email': signUpController.emailTextController.toString(),
                        'password': signUpController.passwordTextController.toString(),
                      };
                      print("data $data");

                      // authViewMode.signupApi(context);
                    }

                  },
                  minimumSize: Size(screenWidth * 0.8, screenHeight * 0.06),
                ),

              ],
            ),
          ),


        ],
      ),
    );
  }
}
