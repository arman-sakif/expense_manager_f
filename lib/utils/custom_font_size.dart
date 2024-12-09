
import 'package:flutter/cupertino.dart';

class CustomFontSize {

  static double largeTextFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 26.0 : 16.00; // Adjust the threshold as needed
  }

  static double? hintsTitleFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 22.0 : null; // Adjust the threshold as needed
  }
  static double titleFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 34.0 : 24.00; // Adjust the threshold as needed
  }


}