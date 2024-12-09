import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../models/expense_list_models.dart';
import '../models/monthly_expense_models.dart';
import '../res/app_urls.dart';

class ParentListRepository {

  BaseApiServices _apiServices = NetworkApiService();

  Future<ExpenseListModel> getExpenselistApi(String userID, String additionUrl)async{
  // Future<ParentListModel> getParentApi(String userId, String additionUrl)async{

    try{
      // dynamic response = await _apiServices.getGetApiResponse("${AppUrl.parentListEndPoint}?user_id=$userId$additionUrl");
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.expenseListEndPoint}?user_id=${userID}");
      print(response);
      // print("additionUrl11 ${AppUrl.parentListEndPoint}?company_id=$companyId$additionUrl");
      return response = ExpenseListModel.fromJson(response) ;

    }catch(e){
      throw e ;
    }
  }
  Future<MonthlyExpenseModel> getMonthlyExpenseApi(String userID, String additionUrl)async{
  // Future<ParentListModel> getParentApi(String userId, String additionUrl)async{

    try{
      // dynamic response = await _apiServices.getGetApiResponse("${AppUrl.parentListEndPoint}?user_id=$userId$additionUrl");
      dynamic response = await _apiServices.getGetApiResponse("${AppUrl.expenseMonthlyEndPoint}?user_id=${userID}");
      print(response);
      // print("additionUrl11 ${AppUrl.parentListEndPoint}?company_id=$companyId$additionUrl");
      return response = MonthlyExpenseModel.fromJson(response) ;

    }catch(e){
      throw e ;
    }
  }

}