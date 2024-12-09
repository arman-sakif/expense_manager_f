import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_manager/controller/profile_controller.dart';
import 'package:expense_manager/models/companyDetails_model.dart';
import 'package:expense_manager/models/profile_model.dart';
import 'package:expense_manager/repository/companyDetails_repository.dart';
import 'package:expense_manager/repository/profile_repository.dart';
import 'package:expense_manager/view_model/user_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/user_model.dart';
import '../utils/utils.dart';


class CompanyDetailsViewModel with ChangeNotifier {
  final _companyRepo = CompanydetailsRepository();
  CompanyDetailsModel? companyDetails;
  Future<UserModel?> getUserData() => UserViewModel().getUser();
  ProfileController profileController = Get.put(ProfileController());


  // Future<UserModel?> getUserData() => UserViewModel().getUser();

  Future<void> companyDetailsApi(BuildContext context, sk_Id) async {
    try {
      print("sk_Id $sk_Id" + "This is from the Company model");


      companyDetails = await _companyRepo.getCompanyDetailsApi(sk_Id);
      notifyListeners();
    } catch (error) {
      Utils.flushBarErrorMessage(
          error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }
    Future<void> companyUpdateApi(BuildContext context) async {
    try {
      UserModel? user = await getUserData();
      String userId = user?.body?.userId.toString() ?? "";
      // String companyId = user?.body?.companyId.toString() ?? "";
      print("sk_Id "+userId +  "This is from the Company model");

      Utils.showLoading(context);

      Map data = {
        "pk_company_id": userId,
        "sk_user_id": userId,
        "corporate_classification": "indevidual",
        "name": profileController.companyNameController.text,
        "name_furigana": "",
        "date_expiry": "",
        "representative_name": profileController.representativeNameController.text,
        "post_code": profileController.postCodeController.text,
        "location_prefecture": "",
        "location_city": "",
        "location_chome": profileController.locationController.text,
        "telephone_number": "",
        "mobile_number": "",
        "fax_number": "",
        "email":profileController.companyEmailController.text,
        "production_area": "",
        "military_name": "",
        "breeder_representation": "",
        "production_prefecture": "",
        "affiliated_park": profileController.parkNameController.text,
        "number": "",
        "representative_name_furigana": "",
        // updated_at should be inserted the latest value from dynamodb
        "updated_at": profileController.updatedAtController.text,
        "status": "1",
        "delete_flag": "0"
      };
      // print(data);
      _companyRepo.updateCompanyApi( data).then((value){

        Utils.cancelLoading(context);

        // Utils.flushBarErrorMessage(AppLocalizations.of(context)!.uploadCompleted, Icons.check,Colors.green, context);
        if(kDebugMode){
          print(value.toString());
        }

        if(value['statusCode'] == "200"){
          // Utils.flushBarErrorMessage(AppLocalizations.of(context)!.uploadCompleted, Icons.check,Colors.green, context);
          // menuController.menuIndex = 1;
          // _pageController = 4;
          // pageValueController.selectedIndex=4;
          Navigator.pop(context,1);
          // Navigator.pushNamedAndRemoveUntil(context, RoutesName.menu, (route)=> false);
        }



      }).onError((error, stackTrace){
        Utils.cancelLoading(context);
        Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
        if(kDebugMode){
          print(error.toString());
        }
      });

    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), Icons.error, Colors.red, context);
      if (kDebugMode) {
        print(error.toString());
      }
    }
  }


}
