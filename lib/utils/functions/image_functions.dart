import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import '../../controller/page_value_controller.dart';
import '../../controller/expense_details_controller.dart';
import '../../models/user_model.dart';
import '../../res/constant.dart';
import '../../res/image_assets.dart';
import '../../view_model/user_view_model.dart';

class ImageManager {
  // Function to load an image from either a file or a URL
  Widget loadImage(dynamic imageSource, double width, double height) {
    // print("imagetest--------------");
    //
    // print(imageSource);
    // print(imageSource is String && imageSource.startsWith('https'));
    // print("--------------");

    if (imageSource is XFile) {
      // print(imageSource.path);
      return kIsWeb ?Image.network(
        imageSource.path,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            ImageAssets.demoImage,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      ):Image.file(
        File(imageSource.path),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            ImageAssets.demoImage,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      );
    } else if (imageSource is String && imageSource.startsWith('http')) {
      // print(imageSource);

      return Image.network(

        kIsWeb
          ? imageSource:

      imageSource,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            ImageAssets.demoImage,
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      return Image.asset(
        ImageAssets.demoImage,
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
  }



  // Function to remove an image from the list
  void removeImage(int index, List<dynamic> imageFiles) {
    if (index < imageFiles.length) {
      imageFiles.removeAt(index);
    }
  }
}
