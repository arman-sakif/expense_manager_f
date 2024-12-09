import 'package:flutter/material.dart';
import '../../res/app_color.dart';

class TitleBoxContainer extends StatelessWidget {
  final String containerName;
  final double? widthSize;
  final double? heightSize;
  final Color? backgroundColor;
  final Color? textColor; // Add this parameter
  final bool? textAlignment;
  final bool? horizontalPadding;
  final bool hasRoundedCorners;

  TitleBoxContainer({
    super.key,
    required this.containerName,
    this.heightSize,
    this.widthSize,
    this.backgroundColor,
    this.textColor, // Initialize it here
    this.textAlignment,
    this.horizontalPadding,
    this.hasRoundedCorners = false,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      //height: screenHeight *0.06,
      height: heightSize != null ? heightSize : screenHeight * 0.06,
      width: widthSize != null ? widthSize : screenWidth * 0.90,
      padding: horizontalPadding == false
          ? EdgeInsets.symmetric(horizontal: 0, vertical: 5)
          : EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.infoTitleBoxColor,
        borderRadius: hasRoundedCorners
            ? BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )
            : BorderRadius.zero,
        // borderRadius: BorderRadius.circular(8),
      ),
      child: Align(
        alignment:
            textAlignment == true ? Alignment.center : Alignment.centerLeft,
        child: Text(
          containerName,
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
