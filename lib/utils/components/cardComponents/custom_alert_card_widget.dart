import 'package:flutter/material.dart';

import '../../../res/image_assets.dart';

/// A customizable alert card widget with optional text, subtext as a button, and an icon.
///
/// This widget displays dynamic text along with an optional icon. The subtext
/// is clickable and can be used as a button. The card's appearance can be customized
/// through several optional parameters.
///
/// Parameters:
/// - [context]: The `BuildContext` in which the widget is built. This is required.
/// - [text]: The main dynamic text to display inside the card. This is required.
/// - [subtext]: Optional. The clickable text to display under the main text.
/// - [buttonImagePath]: Optional. Path for an image to use as the icon.
/// - [onSubtextPressed]: Optional. A callback function triggered when the `subtext` is pressed.
/// - [backgroundColor]: Optional. The background color of the container. Default is white.
/// - [textColor]: Optional. The color of the main text. Default is black.
/// - [subtextColor]: Optional. The color of the subtext. Default is blue.
/// - [borderColor]: Optional. The color of the border. Default is transparent.
/// - [borderRadius]: Optional. The border radius for rounding the corners of the container. Default is 5.0.
/// - [padding]: Optional. The padding inside the container. Default is 16.0.
/// - [borderWidth]: Optional. The width of the container border. Default is 2.0.
Widget customAlertCard({
  required BuildContext context,
  required String text, // The main dynamic text to display in the card
  String? subtext, // Optional: Clickable text to display under the main text
  String? buttonImagePath, // Optional: Path for the image to use as the icon
  VoidCallback? onSubtextPressed, // Optional: Callback function for subtext press
  Color backgroundColor = Colors.white, // Background color for the container
  Color textColor = Colors.black, // Text color for main text
  Color subtextColor = Colors.blue, // Text color for subtext
  Color borderColor = Colors.transparent, // Border color
  double borderRadius = 5.0, // Border radius for card
  double padding = 16.0, // Padding inside the container
  double borderWidth = 1.5,
  double? fontSize = 16,// Width of the border
}) {
  return Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon without onPress functionality
        if (buttonImagePath != null)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              buttonImagePath, // Display image if path is provided
              width: 24.0,
              height: 24.0,
            ),
          ),
        SizedBox(width: 8), // Space between icon and text

        // Column for main text and clickable subtext
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text, // Main text
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                ),
                softWrap: true, // Allows the text to wrap to the next line

                overflow: TextOverflow.clip,
              ),
              SizedBox(height: 10),
              if (subtext != null)
                GestureDetector(
                  onTap: onSubtextPressed, // Makes subtext clickable
                  child: Row(
                    children: [
                      Text(
                        subtext,
                        style: TextStyle(
                          color: subtextColor,
                          fontSize: fontSize,
                        ),
                        softWrap: true, // Allows the text to wrap to the next line

                        overflow: TextOverflow.clip, // Clip overflow without ellipsis, if needed
                      ),
                      SizedBox(width: 8), // Space between icon and text

                      Transform.rotate(
                        angle: 90 * 3.14159 / 180, // Rotate by 90 degrees
                        child: Image.asset(
                          ImageAssets.blueArrowIcon, // Display image if path is provided
                          width: 20.0,
                          height: 20.0,
                        ),
                      ),

                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
