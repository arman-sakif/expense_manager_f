import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../res/app_color.dart';

class TitleBoxRequiredContainer extends StatelessWidget {
  final String containerName;
  final double? widthSize;
  final Color? backgroundColor;
  final bool? textAlignment;

  TitleBoxRequiredContainer({
    super.key,
    required this.containerName,
    this.widthSize,
    this.backgroundColor,
    this.textAlignment,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.06,
      width: widthSize != null ? widthSize : screenWidth * 0.90,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.infoTitleBoxColor,
        // borderRadius: BorderRadius.circular(8),
      ),
      child: Align(
        alignment: textAlignment == true ? Alignment.center : Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: containerName, // Assuming this is the type part
                style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 14,
                ),
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.required, // Assuming this is the required part
                style: TextStyle(
                  color: AppColors.redColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}