import 'package:flutter/material.dart';

import '../../../res/app_color.dart';


class RoundInputField extends StatefulWidget {
  final String name;
  final bool? isPassword;
  TextInputType? type;
  TextEditingController? textEditingController;
  final bool isReadOnly;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  RoundInputField({
    super.key,
    required this.name,
    this.textEditingController,
    this.isPassword = false,
    this.type,
    this.isReadOnly = false,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  State<RoundInputField> createState() => _RoundInputFieldState();
}

class _RoundInputFieldState extends State<RoundInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        border: Border.all(
          color: AppColors.grayColor, // Set the border color to gray
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
              obscureText: widget.isPassword! ? _obscureText : false,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                hintText: widget.name,
                hintStyle: const TextStyle(color: AppColors.grayColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(10.0),
              ),
            ),
          ),
          if (widget.isPassword!)
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.grayLineColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
