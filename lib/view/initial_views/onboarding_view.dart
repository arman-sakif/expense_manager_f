import 'dart:io';
import 'package:concentric_transition/page_view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import '../../routes/routes_name.dart';
import '../../services/auth_services.dart';
import '../../utils/components/onboarding_widgets.dart';
import '../../utils/components/web_fields_common_ui.dart';
import '../../utils/components/web_fields_fontsize.dart';

final pages = [
  const PageData(
    pageId: 0,
    icon: Icons.bubble_chart,
    textColor: AppColors.blackColor,
    bgColor: AppColors.into_first_page_Color,
    imagePath: ImageAssets.onboardingFirstImage,
    // decoration: BoxDecoration(
    //   image: DecorationImage(
    //     image: AssetImage(ImageAssets.backgroundIntro1),
    //     fit: BoxFit.cover,
    //   ),
    // ),

  ),
  const PageData(
    pageId: 1,
    textColor: AppColors.blackColor,
    bgColor: AppColors.into_second_page_Color,
      imagePath: ImageAssets.onboardingSecondImage,
    // decoration: BoxDecoration(
    //   image: DecorationImage(
    //     image: AssetImage(ImageAssets.backgroundIntro2),
    //     fit: BoxFit.cover,
    //   ),
    // ),
  ),
  const PageData(
    pageId: 2,
    textColor: AppColors.blackColor,
    bgColor: AppColors.into_third_page_Color,
      imagePath: ImageAssets.onboardingThirdImage,
    // decoration: BoxDecoration(
    //   image: DecorationImage(
    //     image: AssetImage(ImageAssets.backgroundIntro3),
    //     fit: BoxFit.cover,
    //   ),
    // ),
  ),

];

class Onboarding extends StatelessWidget {
   Onboarding({Key? key}) : super(key: key);

   AuthServices onBoardingServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: ConcentricPageView(
          colors: pages.map((p) => p.bgColor).toList(),
          nextButtonBuilder: (context) => Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Icon(
              Icons.navigate_next,
              // size: screenWidth * 0.08,
              size: WebResponsiveFontSize(customFontSize: 40).calculateFontSize(context),
            ),

          ),
          itemCount: pages.length,
          itemBuilder: (itemCount) {
            final page = pages[itemCount % pages.length];

            return SafeArea(
              child: onboardingPage(page: page),
            );
          },
          onFinish: () async {
            if (kIsWeb) {
              // On web, navigate directly without requesting permissions
              Navigator.pushNamed(context, RoutesName.sign_in);
            } else {
              // Request permissions on mobile platforms
              await handlePermissions();
              // Navigate after permissions are handled
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isFirstRun', true);
              Navigator.pushNamedAndRemoveUntil(context, RoutesName.sign_in, (route)=> false);
            }
          },
        ),
      ),
    );
  }
   Future<void> handlePermissions() async {
     // Request Camera Permission
     await Permission.camera.request();
     // Check Platform and Request Relevant Storage/Photo Permission
     if (Platform.isAndroid) {
       DeviceInfoPlugin plugin = DeviceInfoPlugin();
       AndroidDeviceInfo android = await plugin.androidInfo;
       // Check Android version and request the appropriate permission
       if (android.version.sdkInt < 33) {
         await Permission.storage.request();
       } else {
         await Permission.photos.request();
         await Permission.notification.request();
       }
     } else if (Platform.isIOS) {
       await Permission.photos.request();
       await Permission.notification.request();
     }
   }

}






