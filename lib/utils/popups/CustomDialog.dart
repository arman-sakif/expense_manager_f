import 'package:flutter/material.dart';

import '../components/buttonComponents/custom_rounded_btn.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;

  const CustomDialog({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius here
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), // Adjust the border radius here
          color: Colors.white, // Use your color here
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomButton(
              text: buttonText,
              onPressed: onPressed,
              // minimumSize: Size(screenWidth * 0.8, screenHeight * 0.06),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
