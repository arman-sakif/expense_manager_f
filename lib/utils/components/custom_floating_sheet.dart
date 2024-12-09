import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../res/app_color.dart';
import 'buttonComponents/custom_rounded_btn.dart';



class CustomFloatingActionSheet extends StatelessWidget {
  final Color backgroundColor;
  final List<Map<String, VoidCallback>> buttons;

  CustomFloatingActionSheet({
    required this.backgroundColor,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var button in buttons)
            CustomButton(
              text: button.keys.first,
              onPressed: button.values.first,
              backgroundColor:AppColors.activeBGColor,
              textColor: AppColors.whiteColor,
            ),
          Padding(padding: EdgeInsets.all(10))
        ],
      ),
    );
  }
}