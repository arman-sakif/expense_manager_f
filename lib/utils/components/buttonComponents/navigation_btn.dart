import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../res/app_color.dart';
import '../../../res/image_assets.dart';
import '../textComponents/custom_textview.dart';

class NavigationBtn extends StatelessWidget {
  final String text;
  final String? additionalText;
  final String routeName;
  final bool isRequired;
  final VoidCallback? onPressed; // Add this line


  NavigationBtn({
    required this.text,
    this.additionalText,
    required this.routeName,
    this.isRequired = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  onPressed ?? () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        child: Row(
          children: [
            // spaceWidth(context: context, size: 20),
            CustomText(
              text: text,
              textColor: AppColors.blackColor,
              fontSize: 16,
            ),
            isRequired
                ? CustomText(
                    text: AppLocalizations.of(context)!.required,
                    textColor: AppColors.redColor,
                    fontSize: 16,
                  )
                : Container(),
            Spacer(),
            if (additionalText != null)
              CustomText(
                text: additionalText!,  // Using the null-checked value
                textColor: AppColors.grayLineColor,
                fontSize: 16,
              ),
            Transform.rotate(
              angle: 180 * math.pi / 180,
              child: IconButton(
                icon: const ImageIcon(
                  AssetImage(ImageAssets.backButton),
                  color: AppColors.forwardArrowColor,
                  size: 16,
                ),
                onPressed: onPressed ?? () {
                  Navigator.pushNamed(context, routeName);
                },
              ),
            ),
            // spaceWidth(context: context, size: 20),
          ],
        ),
      ),
    );
  }

}
