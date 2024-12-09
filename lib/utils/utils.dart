import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../res/app_color.dart';
import '../res/image_assets.dart';

class Utils {

  static double largeWidthSize(BuildContext context) {
    return MediaQuery.of(context).size.width > 600 ? 20.0 : 10.00; // Adjust the threshold as needed
  }

  double mediaCalculation(BuildContext context, num value){

    return MediaQuery.of(context).size.height * value;
  }
  static void flushBarErrorMessage(String message, IconData iconData, Color color, BuildContext context){

    showFlushbar(context: context,
      flushbar: Flushbar(
        forwardAnimationCurve:Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 4),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: color,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(iconData , size: 28 , color: Colors.white,),
      )..show(context),

    );

  }

  static Future showLoading(BuildContext context){
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            // Return false to prevent the dialog from being closed
            return false;
          },
          child:  Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            // child: Center(child: CircularProgressIndicator(color: AppColors.ButtonTextColor,)),
            child: Center(child: Image.asset(ImageAssets.splashWaiting, width: 45, height: 45,)),
          ),
        );
      },
    );
  }

  static void cancelLoading(BuildContext context){
    Navigator.pop(context);
  }

}
Widget spaceHeight({required BuildContext context, required double size}) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * size * 0.001,
  );
}
Widget spaceWidth({required BuildContext context, required double size}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * size * 0.001,
  );
}
Widget customDivider({Color? color}) {
  return Divider(
    height: 30,
    thickness: 1,
    indent: 0,
    // endIndent: 10,
    color: color ?? AppColors.lineColor, // Use the passed color or default to AppColors.lineColor
  );
}