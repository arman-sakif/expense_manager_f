import 'package:flutter/material.dart';

import '../../../res/app_color.dart';
import '../../utils.dart';


Future<void> customPopupAlert({
  required BuildContext context,
  required String title,
  required String buttonText,
  required VoidCallback onButtonPressed,
  bool showCloseButton = true,
}) async {
  var screenHeight = MediaQuery.of(context).size.height;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          // padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: screenHeight * 0.01),

              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    showCloseButton
                        ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.close),
                    )
                        : Container(),
                  ],
                ),
              ),
              customDivider(color: AppColors.lineColor),
              GestureDetector(
                onTap: onButtonPressed,
                child: Container(
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: AppColors.inActiveBoxColor,
                    //   width: 2,
                    // ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),

            ],
          ),
        ),
      );
    },
  );
}
