import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controller/confirmation_splash_controller.dart';
import '../../controller/splash_controller.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmationSplashScreen extends StatefulWidget {
  ConfirmationSplashScreen({Key? key}) : super(key: key);

  @override
  _ConfirmationSplashScreenState createState() => _ConfirmationSplashScreenState();
}

class _ConfirmationSplashScreenState extends State<ConfirmationSplashScreen> {
  late ConfirmationSplashController confirmationSplashAnimation;

  @override
  void initState() {
    super.initState();
    confirmationSplashAnimation = Get.put(ConfirmationSplashController());
    confirmationSplashAnimation.confirmationSplashAnimation(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    ConfirmationSplashController.find.confirmationSplashAnimation(context);

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.authenticationComplete,
              style: TextStyle(
                color: AppColors.activeBGColor,
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.01,),
            // spaceHeight(context: context, size: screenHeight * 0.01),
            Center(
              child: Image.asset(
                ImageAssets.confirmationSplash,
                // height: screenHeight * 0.05,
                width: screenWidth * 0.3,
              ),
            ),
            // Space

          ],
        ),
      ),
    );
  }
}
