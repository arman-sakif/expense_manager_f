import 'package:flutter/material.dart';
import '../../../res/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoundedTextMultilineInputField extends StatefulWidget {

  final String name;
  final bool? isPassword;
  TextInputType? type;
  TextEditingController textEditingController;
  final bool isReadOnly;

  RoundedTextMultilineInputField({super.key,
    required this.name,
    required this.textEditingController,
    this.isPassword = false,
    this.type,
    this.isReadOnly = false,
  });

  @override
  State<RoundedTextMultilineInputField> createState() => _RoundedTextInputFieldState();
}

class _RoundedTextInputFieldState extends State<RoundedTextMultilineInputField> {

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height*.2,
          // padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            border: Border.all( // Specify the border properties
              color: AppColors.boarderColor, // Set the border color
              width: 0.9, // Set the border width
            ),
          ),
          child: TextField(
            readOnly: widget.isReadOnly,
            style: TextStyle(fontSize: 13),
            keyboardType: widget.type,
            cursorColor: AppColors.boarderColor,
            controller: widget.textEditingController,
            maxLines: null, // Allow multiple lines
            obscureText:  widget.isPassword! ? _obscureText : false,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: widget.name,
              hintStyle: const TextStyle(color: AppColors.grayColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(8.0),
            ),
          ),
        ),
      ],
    );
  }
}


