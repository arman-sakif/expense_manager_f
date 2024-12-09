import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../res/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon; // Optional icon
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide? border;
  final Size? minimumSize;
  final Size? maximumSize;


  const CustomButton({
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor, // Optional parameter for background color
    this.textColor, // Optional parameter for background color
    this.border, // Optional parameter for border
    this.minimumSize,
    this.maximumSize,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // Size defaultMinimumSize = Size(screenWidth * 0.5, screenHeight * 0.06);
    Size defaultMaximumSize = Size(screenWidth * 0.8, screenHeight * 0.06);
    Size defaultMinimumSize = Size(kIsWeb? (screenWidth > 400 ? screenWidth * 0.2 : screenWidth * 0.9) : screenWidth * 0.5, screenHeight * 0.06);
    // Size defaultMaximumSize = Size(kIsWeb? (screenWidth > 400 ? screenWidth * 0.5 : screenWidth * 0.9) : screenWidth * 0.8, screenHeight * 0.06);
    // if (defaultMinimumSize.width > defaultMaximumSize.width) {
    //   defaultMinimumSize = defaultMaximumSize;
    // }
    return Padding(
      // padding: EdgeInsets.only(top: size.height*.02 , left: 10, right: 10 ),
      padding: EdgeInsets.only(top: screenHeight * 0.02,left: screenWidth*0.04,right: screenWidth*0.04),
      child: Center(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.activeBGColor, // Use provided color or default
            minimumSize: minimumSize ?? defaultMinimumSize,
            maximumSize: maximumSize ?? defaultMaximumSize,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: border ?? BorderSide.none, // Use provided border or no border
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, color: AppColors.whiteColor),
                SizedBox(width: 8),
              ],
              Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white, // Replace with your desired text color
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
