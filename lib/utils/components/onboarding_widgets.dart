import 'package:flutter/material.dart';
import '../../res/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageData {
  final int? pageId;
  final IconData? icon;
  final Color bgColor;
  final Color textColor;
  final String? imagePath;
  // final BoxDecoration? decoration;

  const PageData({
    this.pageId,
    this.icon,
    this.bgColor = AppColors.whiteColor,
    this.textColor = AppColors.blackColor,
    this.imagePath,
    // this.decoration,
  });
}

class onboardingPage extends StatelessWidget {
  final PageData page;

  const onboardingPage({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    space(double p) => SizedBox(height: screenHeight * p / 150);

    String titleText = "";
    String subTitleText = "";
    switch (page.pageId) {
      case 0:
        titleText = AppLocalizations.of(context)!.onboardingFirstTitle;
        subTitleText = AppLocalizations.of(context)!.onboardingFirstSubTitle;
        break;
      case 1:
        titleText = AppLocalizations.of(context)!.onboardingSecondTitle;
        subTitleText = AppLocalizations.of(context)!.onboardingSecondSubTitle;
        break;
      case 2:
        titleText = AppLocalizations.of(context)!.onboardingThirdTitle;
        subTitleText = AppLocalizations.of(context)!.onboardingThirdSubTitle;
        break;
      default:
        titleText = "";
        subTitleText = "";
    }

    final locale = Localizations.localeOf(context).languageCode == 'ja';


    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.09,left: screenWidth * 0.04, right: screenWidth * 0.04),
        child: Column(
          children: [
            onboardingText(
              page: page,
              text: titleText,
              style: TextStyle(
                fontSize: locale ? screenHeight * 0.03 : screenHeight * 0.026,
              ),
            ),
            SizedBox(height:  MediaQuery.of(context).size.height * 0.03,),
            onboardingSmallText(
              page: page,
              text: subTitleText,
              style: TextStyle(
                fontSize: locale ? screenHeight * 0.02 : screenHeight * 0.030,
              ),
            ),
            SizedBox(height: screenHeight * 0.05,),
            Image.asset(
              '${page.imagePath}',
              width: screenWidth * 0.7,
              height: screenHeight * 0.35,
            ),
          ],
        ),
      ),
    );
  }
}

class onboardingText extends StatelessWidget {
  const onboardingText({
    Key? key,
    required this.page,
    required this.text,
    this.style,
  }) : super(key: key);

  final PageData page;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      style: TextStyle(
        color: page.textColor,
        fontWeight: FontWeight.w300,
        fontFamily: 'Inter',
        letterSpacing: 0.0,
        fontSize: 14,
        height: 1,
      ).merge(style),
      textAlign: TextAlign.center,
    );
  }
}

class onboardingSmallText extends StatelessWidget {
  const onboardingSmallText({
    Key? key,
    required this.page,
    required this.text,
    this.style,
  }) : super(key: key);

  final PageData page;
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          text,
          style: TextStyle(
            color: page.textColor,
            fontWeight: FontWeight.w200,
            fontFamily: 'Inter',
            letterSpacing: 0.0,
            fontSize: 2,
            height: 1,
          ).merge(style),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}