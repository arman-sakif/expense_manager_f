import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/repository/child_growth_repository.dart';
import 'package:expense_manager/repository/parent_repository.dart';
import '../controller/menu_controller.dart';
import '../controller/page_value_controller.dart';
import '../repository/child_repository.dart';
import '../routes/routes_name.dart';
import '../utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChildGrowthViewModel with ChangeNotifier {

  MenuViewController menuController = Get.put(MenuViewController());
  PageValueController pageValueController = Get.put(PageValueController());

  final _myRepo = ChildGrowthRepository();

  Future<void> putChildGrowthApi(dynamic data ,  BuildContext context) async {
    Utils.showLoading(context);


    _myRepo.putChildGrowthApi(data).then((value) async {

      Utils.cancelLoading(context);
      if(kDebugMode){
        print(value.toString());
      }
      if(value['statusCode'] == "200"){
        pageValueController.growthDetailsPageValue = 1;
        // Utils.flushBarErrorMessage("Record added successfully",Icons.check,Colors.green,  context);
        // await Future.delayed(Duration(seconds: 2));
        // Navigator.pushNamedAndRemoveUntil(context, RoutesName.menu, (route)=> false);
        // Navigator.pop(context);
        Navigator.pop(context, 4);
        // Utils.cancelLoading(context);

        // Navigator.pushNamed(context, RoutesName.viewGrowthDetails);
      }
      else{
        // Utils.flushBarErrorMessage("Record added successfully",Icons.check,Colors.green,  context);
        // Utils.cancelLoading(context);
      }

      // Navigator.pushNamedAndRemoveUntil(context, RoutesName.menu, (route)=> false);
    }).onError((error, stackTrace){
      Utils.cancelLoading(context);
      Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
      if(kDebugMode){
        print(error.toString());
      }

    });
  }
  Future<int> putChildGrowthEndApi(String childId, String userId, BuildContext context) async {
    Utils.showLoading(context); // Show loading indicator

    Map<String, dynamic> data = {
      "user_id": userId,
      "child_id": childId,
      "child_status": "1",
    };

    try {
      // Call the API and handle the response
      final value = await _myRepo.putChildGrowthEndApi(data);
      Utils.cancelLoading(context); // Hide loading indicator

      if (kDebugMode) {
        print(value.toString()); // Print the response for debugging
      }

      pageValueController.child_user_id=userId;
      // Return the statusCode (e.g., 200, 400)
      return int.parse(value['statusCode']);
    } catch (error) {
      Utils.cancelLoading(context); // Hide loading indicator
      Utils.flushBarErrorMessage(error.toString(), Icons.error, Colors.red, context); // Show error message

      if (kDebugMode) {
        print(error.toString()); // Print error for debugging
      }

      // Return a failure status code or handle error appropriately
      return 500; // For example, return 500 for a general error
    }
  }


}
