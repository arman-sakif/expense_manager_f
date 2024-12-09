
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/notification_models.dart';
import '../res/app_urls.dart';

class NotificationRepository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<NotificationModel> postCreateNotificationChannelApi(dynamic data, String additionUrl)async{
  // Future<ParentListModel> getParentApi(String userId, String additionUrl)async{

    try{
      // print("creating notification channel");
      // print(data);
      // dynamic response = await _apiServices.getGetApiResponse("${AppUrl.parentListEndPoint}?user_id=$userId$additionUrl");
      // dynamic response = await _apiServices.getGetApiResponse("${AppUrl.createNotificationChannelEndPoint}");
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.createNotificationChannelEndPoint, data);

      // print("additionUrl11 ${AppUrl.createNotificationChannelEndPoint}");

      // print("notificationResponse");
      // print(response);
      return response = NotificationModel.fromJson(response) ;

    }catch(e){
      throw e ;
    }
  }

}