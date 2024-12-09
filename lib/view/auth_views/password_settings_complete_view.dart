import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/signup_controller.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import '../../routes/routes_name.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PasswordSettingsCompleteView extends StatefulWidget {
  const PasswordSettingsCompleteView({super.key});

  @override
  State<PasswordSettingsCompleteView> createState() => _PasswordSettingsCompleteViewState();
}

class _PasswordSettingsCompleteViewState extends State<PasswordSettingsCompleteView> {
  SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.05,left: screenWidth*0.08,right: screenWidth*0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: AppLocalizations.of(context)!.registrationComplete,
              textColor: AppColors.blackColor,
              fontSize: 20,),
            SizedBox(height: screenHeight * 0.05),
            CustomText(
              text: AppLocalizations.of(context)!.membershipRegistrationComplete,
              textColor: AppColors.blackColor,
              fontSize: 16,),
            SizedBox(height: screenHeight * 0.05),
            Image.asset(ImageAssets.registrationComplete),
            SizedBox(height: screenHeight * 0.03),
            CustomButton(
              text: AppLocalizations.of(context)!.goToLogin,
              backgroundColor: AppColors.whiteColor,
              textColor: AppColors.activeBGColor,
              onPressed: () {
                signUpController.clearTextFields();
                Navigator.pushNamed(context,RoutesName.sign_in,);
              },
              minimumSize: Size(screenWidth * 0.8, screenHeight * 0.06),
            ),

          ],
        ),
      ),

    );
  }
}
