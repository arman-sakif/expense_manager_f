import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controller/splash_controller.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import '../../utils/components/web_fields_common_ui.dart';
import '../../utils/components/web_fields_fontsize.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashController splashController;

  @override
  void initState() {
    super.initState();
    splashController = Get.put(SplashController());
    splashController.splashAnimation(context);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    SplashController.find.splashAnimation(context);

    return Scaffold(
      backgroundColor: AppColors.screenBGColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // spaceHeight(context: context, size: 25), // Add space here
              // Lottie animation
              Image.asset(
                ImageAssets.appLogo,
                fit: BoxFit.contain,
                width: 100, // Customize the size of the image
                height: 100,
              ),
              // Space
              spaceHeight(context: context, size: 0),
              // Text: Pet App
              Text(
                "Expense App",
                style: TextStyle(
                  color: AppColors.activeBGColor,
                  fontSize: WebResponsiveFontSize().calculateFontSize(context),
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
