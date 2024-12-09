import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../controller/page_value_controller.dart';
import '../../controller/signup_controller.dart';
import '../../res/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../res/image_assets.dart';
import '../../routes/routes_name.dart';
import '../../utils/common_header.dart';
import '../../utils/components/custom_bottom_sheet.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import '../../utils/components/textComponents/round_text_bar.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class ConfirmEmailViewPage extends StatefulWidget {
  const ConfirmEmailViewPage({super.key});

  @override
  State<ConfirmEmailViewPage> createState() => _ConfirmEmailViewPageState();
}

class _ConfirmEmailViewPageState extends State<ConfirmEmailViewPage> {
  SignUpController signUpController = Get.put(SignUpController());
  PageValueController pageValueController = Get.put(PageValueController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHeader(title: AppLocalizations.of(context)!.memberRegistration, hideBackButton: true),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05,left: screenWidth*0.08,right: screenWidth*0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppLocalizations.of(context)!.setPassword,
                  textColor: AppColors.blackColor,
                  fontSize: 16,),
                SizedBox(height: screenHeight * 0.05),
                GestureDetector(
                  onTap: (){
                    showBottomSheetCard(
                      context,
                      AppLocalizations.of(context)!.receiveConfirmationEmail,
                      AppLocalizations.of(context)!.phoneNumberIncorrectly,
                      ImageAssets.confirmation_dog,
                      AppLocalizations.of(context)!.resend,
                          () {
                        // Add functionality for the button
                            pageValueController.registrationPageValue=3;
                            authViewModel.signupApi(context);
                            Navigator.pop(context);
                          },
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Makes the Row as small as its children
                    children: [
                      Image.asset(
                        ImageAssets.roundQuestion,
                        // size: screenWidth * 0.032,
                        height: 16,
                        width: 16,),
                      SizedBox(width: 5), // Adds some space between the text and the icon
                      Text(
                        AppLocalizations.of(context)!.notReceiveCode,
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: AppColors.activeBGColor,
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                CustomButton(
                  text: AppLocalizations.of(context)!.signInText,
                  onPressed: () {
                    signUpController.clearTextFields();

                    Navigator.pushNamed(context,RoutesName.sign_in,);
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
  void showBottomSheetCard(
      BuildContext context, String title, String description, String imagePath, String buttonText, VoidCallback onButtonPressed) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return BottomSheetCardWidget(
          title: title,
          description: description,
          imagePath: imagePath,
          buttonText: buttonText,
          onButtonPressed: onButtonPressed,
        );
      },
    );
  }
}
