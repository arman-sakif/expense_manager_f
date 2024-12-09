import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;

  AppWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double calculatedWidth = kIsWeb
        ? (screenWidth > 400 ? screenWidth * 0.4 : screenWidth * 0.9)
        : double.infinity;

    return Center(
      child: Container(
        width: calculatedWidth,
        child: child,
      ),
    );
  }
}