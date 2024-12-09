import 'package:flutter/material.dart';

import '../../../res/app_color.dart';
import '../../custom_font_size.dart';

class CustomRadioTile extends StatelessWidget {
  final String title;
  final int value;
  final bool isText;
  final int? groupValue;
  final ValueChanged<int?> onChanged;

  CustomRadioTile({
    required this.title,
    required this.isText,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Radio<int>(

            activeColor: AppColors.activeBGColor,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          isText?
          Text(
            title,
            style: TextStyle(fontSize: CustomFontSize.largeTextFontSize(context),),
          ): Image.asset(
            title,
            width: 25,
            height: 25,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}