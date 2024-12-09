import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../data/response/api_response.dart';
import '../models/child_list_models.dart';
import '../models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/view_growth_list_models.dart';
import '../repository/view_growth_list_repository.dart';
import '../utils/utils.dart';
import 'user_view_model.dart';

class ViewGrowthListViewModel with ChangeNotifier {

  final _myRepo = ViewGrowthListRepository();

  ApiResponse<ViewGrowthListModel> viewGrowthList = ApiResponse.loading();
  ApiResponse<ViewGrowthListModel> searchResult = ApiResponse.loading();

  setViewGrowthList(ApiResponse<ViewGrowthListModel> response) {
    viewGrowthList = response;
    notifyListeners();
  }

  setSearchResult(ApiResponse<ViewGrowthListModel> response) {
    searchResult = response;
    notifyListeners();
  }

  Future<UserModel?> getUserData() => UserViewModel().getUser();

  Future<ViewGrowthListModel?> getViewGrowthSearchApi(BuildContext context, String additionUrl, String birthId) async {
    try {
      Utils.showLoading(context);

      UserModel? user = await getUserData();
      String userId = user?.body?.userId.toString() ?? "";

      ViewGrowthListModel value = await _myRepo.getViewGrowthSearchApi(birthId, additionUrl);
      Utils.cancelLoading(context);

      if (value.statusCode == "200") {
        return value;
      }
      else if (value.statusCode == "404") {
        // Utils.cancelLoading(context);
        Utils.flushBarErrorMessage(AppLocalizations.of(context)!.noData, Icons.error, Colors.red, context);
        print(AppLocalizations.of(context)!.noData);
      }
      else if (value.statusCode == "404") {
        // Utils.cancelLoading(context);
        Utils.flushBarErrorMessage(AppLocalizations.of(context)!.noData, Icons.error, Colors.red, context);
        print(AppLocalizations.of(context)!.noData);
      }else {
        Utils.flushBarErrorMessage(AppLocalizations.of(context)!.noPetFound, Icons.error, Colors.red, context);
        return null;
      }
    } catch (error) {
      Utils.cancelLoading(context);
      // String errorMessage = error['body']['error'];
      print(error);
      Utils.flushBarErrorMessage(AppLocalizations.of(context)!.noBirthRecord, Icons.error, Colors.red, context);
      return null;
    }
  }


  Future<void> getViewGrowthListApi(BuildContext context, String additionUrl)async{

    print("additionUrl7 $additionUrl");
    setViewGrowthList(ApiResponse.loading());

    UserModel? user = await getUserData();
    String userId = user?.body?.userId.toString() ?? "";
    // Utils.showLoading(context);

    _myRepo.getViewGrowthListApi(userId, additionUrl).then((value){

      // print("additionUrl16 $additionUrl");

      Future.delayed(const Duration(milliseconds: 500), () {
        // print("additionUrl17 $additionUrl");
        // Utils.cancelLoading(context);

        // print("additionUrl18 $additionUrl");
        notifyListeners();
        setViewGrowthList(ApiResponse.completed(value));

        if (kDebugMode) {
          // print("${value.body}");
        }
      });


    }).onError((error, stackTrace){

      Future.delayed(const Duration(milliseconds: 500), () {

        Utils.cancelLoading(context);
        Utils.flushBarErrorMessage(error.toString(),Icons.error,Colors.red,  context);
        if(kDebugMode){
          // print(error.toString());
        }
        // setNotificationList(ApiResponse.error(error.toString()));
      });


    });

  }


}

