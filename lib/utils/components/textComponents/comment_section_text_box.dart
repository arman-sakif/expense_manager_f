import 'package:flutter/material.dart';
import '../../../res/app_color.dart';

class BigRoundInputField extends StatefulWidget {
  final String name;
  final bool? isPassword;
  final TextInputType? type;
  final bool isReadOnly;
  final double height;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final int? maxLength;
  final TextEditingController? textEditingController;

  BigRoundInputField({
    Key? key,
    required this.name,
    this.isPassword = false,
    this.type,
    this.isReadOnly = false,
    this.onChanged,
    this.onSubmitted,
    this.height = 50.0,
    this.maxLength,
    this.textEditingController,
  }) : super(key: key);

  @override
  State<BigRoundInputField> createState() => _RoundInputFieldState();
}

class _RoundInputFieldState extends State<BigRoundInputField> {
  late TextEditingController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.textEditingController ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.textEditingController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: AppColors.grayColor,
          width: 0.9,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 0.0, right: 5),
        child: TextField(
          controller: _controller,
          readOnly: widget.isReadOnly,
          style: TextStyle(fontSize: 13),
          keyboardType: widget.type,
          obscureText: widget.isPassword! ? _obscureText : false,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          maxLines: null,
          maxLength: widget.maxLength,
          textInputAction: TextInputAction.done, // Add this line
          decoration: InputDecoration(
            hintText: widget.name,
            hintStyle: TextStyle(
              color: AppColors.grayColor,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            counterText: '',
          ),
          textAlignVertical: TextAlignVertical.top,
        ),
      ),
    );
  }
}
