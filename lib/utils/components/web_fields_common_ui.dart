import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

class WebResponsiveWidthContainer extends StatelessWidget {
  final double? customWidth;

  WebResponsiveWidthContainer({this.customWidth});

  double calculateWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return customWidth ?? (kIsWeb
        ? (screenWidth > 400 ? screenWidth * 0.2 : screenWidth * 0.9)
        : screenWidth * 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: calculateWidth(context),
    );
  }
}