import 'package:flutter/material.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import 'buttonComponents/custom_rounded_btn.dart';

class BottomSheetCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String buttonText;
  final VoidCallback onButtonPressed;

  BottomSheetCardWidget({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.all(screenHeight * 0.03),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(right: screenHeight * 0.03),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(ImageAssets.crossIcon),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.00),
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
            child: Image.asset(
              imagePath,
              height: 100,
              width: 100,
            ),
          ),
          Center(
            child: Text(
              description,
              style: TextStyle(fontSize: 13,color: AppColors.forwardArrowColor),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomButton(
            text: buttonText,
            backgroundColor: AppColors.activeBGColor,
            onPressed: onButtonPressed,
          ),
        ],
      ),
    );
  }
}
