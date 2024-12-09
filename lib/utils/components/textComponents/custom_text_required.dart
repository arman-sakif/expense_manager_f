import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../res/app_color.dart';

class CustomTextRequired extends StatelessWidget {
  final String text;
  final bool isRequired;
  final double fontSize;

  CustomTextRequired({
    Key? key,
    required this.text,
    this.isRequired = true,
    this.fontSize = 14.0, // Default font size

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text, // Assuming this is the type part
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: fontSize, // Use the fontSize passed in
            ),
          ),
          if (isRequired)
            TextSpan(
              text: ' ${AppLocalizations.of(context)!.required}', // Assuming this is the required part
              style: TextStyle(
                color: AppColors.redColor,
                fontSize: fontSize, // Use the same fontSize
              ),
            ),
        ],
      ),
    );
  }
}
