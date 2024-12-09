import 'package:expense_manager/utils/components/textComponents/custom_textview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:provider/provider.dart';
import '../../controller/change_password_controller.dart';
import '../../controller/signup_controller.dart';
import '../../res/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/common_header.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/round_text_bar.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class RequestResetPasswordPage extends StatefulWidget {
  const RequestResetPasswordPage({super.key});

  @override
  State<RequestResetPasswordPage> createState() =>
      _RequestResetPasswordPageState();
}

class _RequestResetPasswordPageState extends State<RequestResetPasswordPage> {
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());
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
          CommonHeader(
              title: AppLocalizations.of(context)!.forgetPassConfirmTitle,
              hideBackButton: false),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.05,
                    left: screenWidth * 0.08,
                    right: screenWidth * 0.08),
                child: Column(
                  children: [
                    CustomText(
                      text: "${changePasswordController.resetPassEmailTextController.text} ${AppLocalizations.of(context)!.resetOtpAndPasswordEnterText} ",
                      textColor: AppColors.blackColor,
                      fontSize: 16,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                        text: AppLocalizations.of(context)!.authenticationCode,
                        textColor: AppColors.blackColor,
                        fontSize: 16,
                      ),
                    ),
                    RoundInputField(
                      // name: AppLocalizations.of(context)!.parkNumber,
                      name: AppLocalizations.of(context)!.authenticationCode,
                      onChanged: (value) {
                        changePasswordController
                            .otpResetPasswordTextController.text = value;
                        setState(() {});
                      }, onSubmitted: (value) {
                      changePasswordController
                          .otpResetPasswordTextController.text = value;
                    },
                      // textEditingController: signUpNameController,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          text: AppLocalizations.of(context)!.password,
                          textColor: AppColors.blackColor,
                          fontSize: 16,
                        )),
                    SizedBox(height: screenHeight * 0.005),
                    RoundInputField(
                      name: AppLocalizations.of(context)!.enterPassword,
                      isPassword: true,
                      // textEditingController: signUpPasswordController,
                      onChanged: (value) {
                        changePasswordController
                            .newResetPasswordTextController.text = value;
                        setState(() {});
                      },
                      onSubmitted: (value) {
                        changePasswordController
                            .newResetPasswordTextController.text = value;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          text: AppLocalizations.of(context)!.passwordConfirm,
                          textColor: AppColors.blackColor,
                          fontSize: 16,
                        )),
                    SizedBox(height: screenHeight * 0.005),
                    RoundInputField(
                      name: AppLocalizations.of(context)!.confirmPasswordText,
                      isPassword: true,
                      onChanged: (value) {
                        changePasswordController
                            .confirmResetPasswordTextController.text = value;
                        setState(() {});
                      },
                      onSubmitted: (value) {
                        changePasswordController
                            .confirmResetPasswordTextController.text = value;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomButton(
                      text: AppLocalizations.of(context)!.confirm,
                      onPressed: () {
                        // Navigator.pushNamed(context,RoutesName.password_settings,);

                        if (changePasswordController
                                .newResetPasswordTextController.text.isEmpty ||
                            changePasswordController
                                .confirmResetPasswordTextController.text.isEmpty||changePasswordController
                            .otpResetPasswordTextController.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              AppLocalizations.of(context)!.requiredFields,
                              Icons.error,
                              Colors.red,
                              context);
                        } else if (changePasswordController
                                .newResetPasswordTextController.text.isEmpty ||
                            changePasswordController
                                .confirmResetPasswordTextController.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              AppLocalizations.of(context)!.passwordConfirmPassword,
                              Icons.error,
                              Colors.red,
                              context);
                        } else if (changePasswordController
                                .newResetPasswordTextController.text.length <
                            6) {
                          Utils.flushBarErrorMessage(
                              AppLocalizations.of(context)!.atLeastSixCharacters,
                              Icons.error,
                              Colors.red,
                              context);
                        }else if (changePasswordController
                                .otpResetPasswordTextController.text.length <
                            5) {
                          Utils.flushBarErrorMessage(
                              AppLocalizations.of(context)!.atLeastSixCharacters,
                              Icons.error,
                              Colors.red,
                              context);
                        } else if (changePasswordController
                                .confirmResetPasswordTextController.text !=
                            changePasswordController
                                .newResetPasswordTextController.text) {
                          Utils.flushBarErrorMessage(
                              AppLocalizations.of(context)!.passwordsNotMatch,
                              Icons.error,
                              Colors.red,
                              context);
                        } else {

                          authViewMode.passwordChangeConfirmApi(context);
                        }
                      },
                      minimumSize: Size(screenWidth * 0.8, screenHeight * 0.06),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
