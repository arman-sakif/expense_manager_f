import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../controller/page_value_controller.dart';
import '../../controller/signin_controller.dart';
import '../../controller/signup_controller.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import '../../routes/routes_name.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import '../../utils/components/textComponents/round_text_bar.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  int registrationTypeValue = 0;

  // SignUpController signUpController = Get.put(SignUpController());
  SignInController signInController = Get.put(SignInController());
  PageValueController pageValueController = Get.put(PageValueController());


  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            // color: Colors.green,
            // padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
            padding: EdgeInsets.only(top: screenHeight * 0.05,left: screenWidth*0.08,right: screenWidth*0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageAssets.appLogo,
                    fit: BoxFit.contain,
                    width: 100, // Customize the size of the image
                    height: 100,
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                CustomText(
                  text: AppLocalizations.of(context)!.emailAddressText,
                  textColor: AppColors.blackColor,
                  fontSize: 16,
                ),
                RoundInputField(
                  name: AppLocalizations.of(context)!.pleaseEnter,
                  // textEditingController: signInEmailController,
                  onChanged: (value) {
                    signInController.emailTextController = value;
                    setState(() {});
                  },
                  onSubmitted: (value){
                    signInController.emailTextController = value;
                  },
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomText(
                  text: AppLocalizations.of(context)!.password,
                  textColor: AppColors.blackColor,
                  fontSize: 16,),
                RoundInputField(
                  name: AppLocalizations.of(context)!.passwordConfirmPassword,
                  isPassword: true,
                  // textEditingController: signInPasswordController,
                  onChanged: (value) {
                    signInController.passwordTextController = value;
                    setState(() {});
                  },
                  onSubmitted: (value){
                    signInController.passwordTextController = value;
                  },
                ),
                // if (_signInError != null)
                //   Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 5.0),
                //     child: Text(
                //       _signInError!,
                //       style: TextStyle(color: Colors.red, fontSize: 12),
                //     ),
                //   ),
                SizedBox(height: screenHeight * 0.005),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {

                      Navigator.pushNamed(context,RoutesName.otp_verify);

                    },
                    child: Text(
                      AppLocalizations.of(context)!.forgetPass,
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.activeBGColor,
                        color: AppColors.activeBGColor,
                      ),
                    ),
                  ),
                ),
                CustomButton(
                  text: AppLocalizations.of(context)!.signInText,
                  onPressed: () {
                    // Navigator.pushNamedAndRemoveUntil(context, RoutesName.menu, (route)=> false);

                    if (signInController.emailTextController.isEmpty ||
                        signInController.passwordTextController.isEmpty) {
                      Utils.flushBarErrorMessage(
                          AppLocalizations.of(context)!.requiredFields,
                          Icons.error,
                          Colors.red,
                          context);
                    } else if (!EmailValidator.validate(
                        signInController.emailTextController)) {
                      Utils.flushBarErrorMessage(
                          AppLocalizations.of(context)!
                              .validEmailAddress,
                          Icons.error,
                          Colors.red,
                          context);
                    } else if (signInController
                        .passwordTextController.length <
                        6) {
                      Utils.flushBarErrorMessage(
                          AppLocalizations.of(context)!
                              .atLeastSixCharacters,
                          Icons.error,
                          Colors.red,
                          context);
                    }else {
                      authViewMode.signInApi(context);
                    }


                  },
                  minimumSize: Size(screenWidth * 0.8, screenHeight * 0.06),
                ),
                SizedBox(height: screenHeight * 0.03),
                if (kIsWeb || Platform.isAndroid)                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      // Navigator.pushNamedAndRemoveUntil(context, RoutesName.sign_up,(route)=> false);
                      // Navigator.pushNamed(context,RoutesName.otp_verify,);
                      pageValueController.registrationPageValue=registrationTypeValue;
                      Navigator.pushNamed(context,RoutesName.sign_up,);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Makes the Row as small as its children
                      children: [
                        Text(
                          AppLocalizations.of(context)!.registerNow,
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.activeBGColor,
                            color: AppColors.activeBGColor,
                          ),
                        ),
                        SizedBox(width: 5), // Adds some space between the text and the icon
                        Icon(
                          Icons.arrow_forward_ios, // Choose the arrow icon you prefer
                          color: AppColors.activeBGColor,
                          size: 14, // Match the icon size with the text size
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
