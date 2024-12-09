import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import '../../controller/change_password_controller.dart';
import '../../res/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../routes/routes_name.dart';
import '../../utils/common_header.dart';
import '../../utils/components/buttonComponents/custom_rounded_btn.dart';
import '../../utils/components/textComponents/custom_textview.dart';
import '../../utils/components/textComponents/round_text_bar.dart';
import '../../view_model/auth_view_model.dart';

class OtpVerifyView extends StatefulWidget {
  const OtpVerifyView({super.key});

  @override
  State<OtpVerifyView> createState() => _OtpVerifyViewState();
}

class _OtpVerifyViewState extends State<OtpVerifyView> {
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
        children: [
          CommonHeader(title: AppLocalizations.of(context)!.forgetPassRequestTitle),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05,left: screenWidth*0.08,right: screenWidth*0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: AppLocalizations.of(context)!.enterEmailForAuthentication,
                  textColor: AppColors.blackColor,
                  fontSize: 16,),
                SizedBox(height: screenHeight * 0.03),
                CustomText(
                  text: AppLocalizations.of(context)!.emailAddressText,
                  textColor: AppColors.blackColor,
                  fontSize: 16,),
                RoundInputField(
                  name: AppLocalizations.of(context)!.emailAddressText,
                  // textEditingController:,
                  onChanged: (value) {
                    changePasswordController.resetPassEmailTextController.text = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                changePasswordController.resetPassEmailTextController.text==""?
                CustomButton(
                  text: AppLocalizations.of(context)!.confirm,
                   backgroundColor:AppColors.grayColor,
                  onPressed: () {
                    // Navigator.pushNamed(context,RoutesName.password_settings,);
                  },
                  minimumSize: Size(screenWidth * 0.8, screenHeight * 0.06),
                ):CustomButton(
                  text: AppLocalizations.of(context)!.confirm,
                  onPressed: () {
                    authViewMode.passwordChangeRequestApi(context);


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
