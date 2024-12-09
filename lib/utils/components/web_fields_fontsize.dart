import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

class WebResponsiveFontSize {
  final double? customFontSize;

  WebResponsiveFontSize({this.customFontSize});

  double calculateFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return customFontSize ?? (kIsWeb
        ? (screenWidth > 400 ? screenWidth * 0.02 : screenWidth * 0.05)
        : screenWidth * 0.06);
  }
}