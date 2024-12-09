import 'package:flutter/material.dart';
import '../../../res/app_color.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isBold;
  final double fontSize;
  final Color textColor;
  final TextStyle? customStyle;
  // final FocusNode? focusNode; // Add FocusNode

  const CustomText({
    Key? key,
    required this.text,
    this.isBold = false,
    this.fontSize = 20.0, // Default font size
    this.textColor = AppColors.blackColor, // Default text color
    this.customStyle,
    // this.focusNode, // Custom text style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      // focusNode != null
      //   ? Focus(
      //       focusNode: focusNode, // Attach FocusNode if provided
      //       child: Text(
      //         text,
      //         style: customStyle ??
      //             TextStyle(
      //               color: textColor,
      //               fontSize: fontSize,
      //               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      //             ),
      //       ),
      //     )
      //   :
    Text(
            text,
            style: customStyle ??
                TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
          );
  }
}
