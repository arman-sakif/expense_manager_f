import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import '../../utils/components/textComponents/custom_text_required.dart';
import '../../utils/components/textComponents/custom_textview.dart';

class ListSelectionContainer extends StatelessWidget {
  final String title;
  final String selectedName;
  final Color textColor;
  final VoidCallback onTap;
  final bool required;


  const ListSelectionContainer({
    Key? key,
    required this.title,
    required this.selectedName,
    this.required = true,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: screenWidth * 0.01, bottom: screenWidth * 0.01),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
                child: CustomTextRequired(text: title,isRequired: required)),
            SizedBox(width: screenWidth * 0.02),

            Expanded(
              child: Align(
                alignment: Alignment.centerRight, // Align CustomText to the right

                child: CustomText(

                  text: selectedName,
                  // textColor: selectedName==""?AppColors.inactiveBorderColor:AppColors.blackColor,
                  textColor: textColor,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Image.asset(
              ImageAssets.forwardArrow,
              width: 16,
              height: 16,
            ),
            SizedBox(width: screenWidth * 0.02),
          ],
        ),
      ),
    );
  }
}
