import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../res/app_color.dart';

class CustomContainer extends StatelessWidget {
  final String text;
  final double? marginTop;
  final double? marginBottom;
  final double? marginLeft;
  final double? marginRight;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide? border;
  final AlignmentGeometry alignment; // Add this parameter
  final double? borderRadius; // Add this parameter


  const CustomContainer({Key? key,
    required this.text,
     this.marginTop,
     this.marginBottom,
     this.marginLeft,
     this.marginRight,
    this.border, // Optional parameter for border
    this.backgroundColor,
     this.textColor,
     this.alignment = Alignment.center, // Default alignment is center
     this.borderRadius, // Add this parameter


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight *0.038,
      // width: screenWidth *0.20,
      width: kIsWeb
          ? (screenWidth > 400 ? screenWidth * 0.10 : screenWidth * 0.9) : screenWidth * 0.17,
      margin: EdgeInsets.only(
        top: marginTop ?? 0,
       bottom: marginBottom ?? 0,
       left: marginLeft ?? 0,
       right:  marginRight?? 0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.lightBGColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        border: border != null ? Border.all(color: border!.color, width: border!.width) : null,

      ),
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.blackColor,
          // fontSize: 10,
          fontSize: kIsWeb ? (screenWidth > 400 ? screenWidth * 0.008 : screenWidth * 0.9) : screenWidth * 0.024,
        ),
      ),
    );
  }
}