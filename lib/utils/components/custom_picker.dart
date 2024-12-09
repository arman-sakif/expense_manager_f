import 'package:flutter/material.dart';
import '../../res/app_color.dart';
import '../../res/image_assets.dart';
import 'textComponents/custom_textview.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomPicker extends StatefulWidget {

  final String? title;
  final String dateTypeText;
  final String? additionalText;
  final VoidCallback selectDateFunction;
  final bool isRequired;

  const CustomPicker({super.key,
     this.title,
    required this.dateTypeText,
    this.additionalText,
    required this.selectDateFunction,
    this.isRequired = true,
  });

  @override
  State<CustomPicker> createState() => _CustomPickerState();
}

class _CustomPickerState extends State<CustomPicker> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return  Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: widget.selectDateFunction,
          child: Row(
            children: <Widget>[
              Container(
                child: Text(widget.dateTypeText, style: TextStyle(fontSize: 15),

                ),
              ),
              SizedBox(width: 2), // Add spacing between resultText and required
              if (widget.isRequired)
                CustomText(
                  text: AppLocalizations.of(context)!.required,
                  textColor: AppColors.redColor,
                  fontSize: 14,
                ),
              // widget.isRequired
              //     ? CustomText(
              //   text: AppLocalizations.of(context)!.required,
              //   textColor: AppColors.redColor,
              //   fontSize: 14,
              // )
              //     : Container(),
              Spacer(),
              if (widget.additionalText != null)
                CustomText(
                  text: widget.additionalText!,  // Using the null-checked value
                  textColor:

                  // widget.isRequired?

                  AppColors.grayLineColor
                      // :AppColors.blackColor
                  ,
                  fontSize: 16,
                ),
              SizedBox(width: 5),
              Container(
                // color: Colors.green,
                height: 20,
                width: 20,
                child: Transform.scale(
                  scale: 4.5,  // Adjust to zoom in
                  child: IconButton(
                    icon: Image.asset(
                      ImageAssets.calendarIcons,
                      width: 14,
                      height: 14,
                    ),
                    onPressed: widget.selectDateFunction,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
