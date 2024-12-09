import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/view_model/user_view_model.dart';
import '../data/response/api_response.dart';
import '../models/expense_list_models.dart';
import '../models/monthly_expense_models.dart';
import '../models/user_model.dart';
import '../repository/parent_list_repository.dart';
import '../utils/utils.dart';
class ExpenseListViewModel with ChangeNotifier {
  final _myRepo = ParentListRepository();

  // Store for parent list
  ApiResponse<ExpenseListModel> parentList = ApiResponse.loading();

  // Store for monthly expense response
  ApiResponse<MonthlyExpenseModel> monthlyExpense = ApiResponse.loading();

  // Setter for parent list
  setParentList(ApiResponse<ExpenseListModel> response) {
    parentList = response;
    notifyListeners();
  }

  // Setter for monthly expense
  setMonthlyExpense(ApiResponse<MonthlyExpenseModel> response) {
    monthlyExpense = response;
    notifyListeners();
  }

  Future<UserModel?> getUserData() => UserViewModel().getUser();

  Future<void> getParentApi(BuildContext context, String additionUrl) async {
    setParentList(ApiResponse.loading());

    UserModel? user = await getUserData();
    String userId = user?.body?.userId.toString() ?? "";

    _myRepo.getExpenselistApi(userId, additionUrl).then((value) {
      Future.delayed(const Duration(milliseconds: 500), () {
        notifyListeners();
        setParentList(ApiResponse.completed(value));
      });
    }).onError((error, stackTrace) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Utils.cancelLoading(context);
        Utils.flushBarErrorMessage(
            error.toString(), Icons.error, Colors.red, context);
      });
    });
  }

  // Update to get monthly expense
  Future<void> getMonthlyExpenseApi(BuildContext context, String additionUrl) async {
    setMonthlyExpense(ApiResponse.loading());

    UserModel? user = await getUserData();
    String userId = user?.body?.userId.toString() ?? "";

    _myRepo.getMonthlyExpenseApi(userId, additionUrl).then((value) {
      Future.delayed(const Duration(milliseconds: 500), () {
        setMonthlyExpense(ApiResponse.completed(value));
      });
    }).onError((error, stackTrace) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Utils.cancelLoading(context);
        Utils.flushBarErrorMessage(
            error.toString(), Icons.error, Colors.red, context);
      });
    });
  }
}