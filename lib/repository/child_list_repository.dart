import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/child_list_models.dart';
import '../res/app_urls.dart';

class ChildListRepository {

  BaseApiServices _apiServices = NetworkApiService();

  // Future<ChildListModel> getChildApi(String userId, String additionUrl)async{
  Future<ChildListModel> getChildApi(String companyId, String additionUrl)async{

    try{
      // print(companyId);
      // dynamic response = await _apiServices.getGetApiResponse("${AppUrl.childListEndPoint}?user_id=$userId$additionUrl");
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.childListEndPoint}?company_id=$companyId$additionUrl");
      // print("additionUrl11 ${AppUrl.childListEndPoint}?company_id=$companyId$additionUrl");
      return response = ChildListModel.fromJson(response) ;

    }catch(e){
      throw e ;
    }
  }
  Future<ChildListModel> getViewGrowthListApi(String userId, String additionUrl)async{

    try{
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.viewGrowthListEndPoint}?sk_user_id=$userId$additionUrl");
      print("additionUrl13 ${AppUrl.viewGrowthListEndPoint}?sk_user_id=$userId$additionUrl");
      return response = ChildListModel.fromJson(response) ;

    }catch(e){
      throw e ;
    }
  }
  Future<ChildListModel> getViewGrowthSearchApi(String birth_id, String additionUrl)async{

    try{
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.viewGrowthSearchEndPoint}?birth_id=$birth_id$additionUrl");
      print("additionUrl14 ${AppUrl.viewGrowthSearchEndPoint}?birth_id=$birth_id$additionUrl");
      return response = ChildListModel.fromJson(response) ;

    }catch(e){
      throw e ;
    }
  }

}