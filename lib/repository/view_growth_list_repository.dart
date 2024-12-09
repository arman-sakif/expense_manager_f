import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/view_growth_list_models.dart';
import '../res/app_urls.dart';

class ViewGrowthListRepository {

  BaseApiServices _apiServices = NetworkApiService();

  // Future<ViewGrowthListModel> getViewGrowthApi(String userId, String additionUrl)async{
  //
  //   try{
  //     dynamic response = await _apiServices.getGetApiResponse("${AppUrl.childListEndPoint}?user_id=$userId$additionUrl");
  //     print("additionUrl11 ${AppUrl.childListEndPoint}?user_id=$userId$additionUrl");
  //     return response = ViewGrowthListModel.fromJson(response) ;
  //
  //   }catch(e){
  //     throw e ;
  //   }
  // }
  Future<ViewGrowthListModel> getViewGrowthListApi(String userId, String additionUrl)async{

    try{
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.viewGrowthListEndPoint}?sk_user_id=$userId$additionUrl");
      // print("additionUrl13 ${AppUrl.viewGrowthListEndPoint}?sk_user_id=$userId$additionUrl");
      return response = ViewGrowthListModel.fromJson(response) ;

    }catch(e){
      throw e ;
    }
  }
  Future<ViewGrowthListModel> getViewGrowthSearchApi(String birth_id, String additionUrl)async{

    try{
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.viewGrowthSearchEndPoint}?birth_id=$birth_id$additionUrl");
      // print("additionUrl14 ${AppUrl.viewGrowthSearchEndPoint}?birth_id=$birth_id$additionUrl");
      return response = ViewGrowthListModel.fromJson(response) ;

    }catch(e){
      throw e ;
    }
  }

}