import 'package:flutter/cupertino.dart';

class CustomImageSize {

  static double cameraGalleryIconSize(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 36.0 : 24.00; // Adjust the threshold as needed
  }
  static double hintsImageFontSize(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 34.0 : 24.00; // Adjust the threshold as needed
  }
  static double closeIconSize(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 40.0 : 35.00; // Adjust the threshold as needed
  }

}