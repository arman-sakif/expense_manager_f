import 'package:flutter/material.dart';
import '../res/app_color.dart';
import '../res/image_assets.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final bool hideBackButton;
  final VoidCallback? onBackPress;

  CommonHeader({
    required this.title,
    this.hideBackButton = false,
    this.onBackPress,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: AppColors.whiteColor,
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            if (!hideBackButton)
              IconButton(
              icon: Image.asset(
                ImageAssets.backButton, // Change this to your actual asset path
                width: 24,
                height: 24,
              ),
                onPressed: onBackPress ?? () {
                  Navigator.of(context).pop();
                },
                          ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      // fontSize: CustomFontSize.medicineBookFontSize(context),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}