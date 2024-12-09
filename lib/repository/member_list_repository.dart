import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/member_list_models.dart';
import '../res/app_urls.dart';

class MemberListRepository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<MemberModel> getMemberApi(String companyId, String additionUrl)async{

    try{
      // print("additionUrl11 ${AppUrl.memberListEndPoint}?sk_id=$companyId");
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.memberListEndPoint}?sk_id=$companyId$additionUrl");

      // print(response);
      return response = MemberModel.fromJson(response) ;

    }catch(e){
      throw e ;
    }
  }

}