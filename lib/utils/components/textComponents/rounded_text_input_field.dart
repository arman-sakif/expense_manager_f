import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../res/app_color.dart';

class RoundedTextInputField extends StatefulWidget {
  final String name;
  final double? widthSize;
  final bool? isPassword;
  final TextInputType? type;
  final TextEditingController textEditingController;
  final bool isReadOnly;
  final double height;
  final int characterLimit;
  final EdgeInsetsGeometry contentPadding;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  RoundedTextInputField({
    Key? key,
    required this.name,
    required this.textEditingController,
    this.isPassword = false,
    this.widthSize,
    this.type,
    this.isReadOnly = false,
    this.height = 50.0,
    this.characterLimit = 50,
    this.contentPadding = const EdgeInsets.all(10.0), // Default padding
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<RoundedTextInputField> createState() => _RoundedTextInputFieldState();
}

class _RoundedTextInputFieldState extends State<RoundedTextInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    widget.widthSize;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.height,
          width: widget.widthSize,
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            border: Border.all(
              color: AppColors.boarderColor,
              width: 0.9,
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  readOnly: widget.isReadOnly,
                  style: TextStyle(fontSize: 13),
                  keyboardType: widget.type,
                  controller: widget.textEditingController,
                  cursorColor: AppColors.boarderColor,
                  obscureText: widget.isPassword! ? _obscureText : false,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(widget.characterLimit),
                  ],
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                  decoration: InputDecoration(
                    hintText: widget.name,
                    hintStyle: const TextStyle(color: AppColors.grayColor),
                    border: InputBorder.none,
                    contentPadding: widget.contentPadding,
                    suffixIcon: widget.isPassword!
                        ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.grayColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                        : null,
                  ),
                  textAlignVertical: TextAlignVertical.top, // Align text to the top
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
