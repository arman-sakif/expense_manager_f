import 'package:flutter/material.dart';

import '../../res/app_color.dart';
import '../../utils/utils.dart';

Future<bool?> showCustomDialog({
  required BuildContext context,
  required String title,
  required String leftButtonText,
  required String rightButtonText,
  required Function() onLeftButtonPressed,
  required Function() onRightButtonPressed,
  bool showCloseButton = true, // New parameter with default true
}) async {
  var screenHeight = MediaQuery.of(context).size.height;

  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Adjust the border radius here
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white, // Use your AppColors here if necessary
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    showCloseButton?
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(false); // Close dialog and return false
                      },
                      child: Icon(Icons.close),
                    ):Container(),
                  ],
                ),
              ),
              // Divider(
              //   color: Colors.grey, // Use your customDivider here if necessary
              // ),
              customDivider(color: AppColors.infoTitleBoxColor,),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            onLeftButtonPressed();
                            // Navigator.of(context).pop(false); // Return false on left button press
                          } else if (index == 1) {
                            onRightButtonPressed();
                            // Navigator.of(context).pop(true); // Return true on right button press
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                          height: screenHeight * 0.07,
                          decoration: BoxDecoration(
                            border: Border.all(
                              // color: index == 0 ? AppColors.activeBoxColor : AppColors.inActiveBoxColor,
                              color: AppColors.inActiveBoxColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              index == 0 ? leftButtonText : rightButtonText,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black, // Use your AppColors here if necessary
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: screenHeight * 0.03),
            ],
          ),
        ),
      );
    },
  );
}
