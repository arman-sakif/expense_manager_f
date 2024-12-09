import 'dart:convert';

ExpenseListModel expenseListModelFromJson(String str) => ExpenseListModel.fromJson(json.decode(str));

String expenseListModelToJson(ExpenseListModel data) => json.encode(data.toJson());

class ExpenseListModel {
  String? statusCode;
  String? message;
  List<Expense>? data;

  ExpenseListModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory ExpenseListModel.fromJson(Map<String, dynamic> json) => ExpenseListModel(
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<Expense>.from(json["data"].map((x) => Expense.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data?.map((x) => x.toJson()).toList(),
  };
}

class Expense {
  DateTime? timeOfUse;
  String? pkExpenseId;
  String? productName;
  String? skUserId;
  String? expenseAmount;

  Expense({
    this.timeOfUse,
    this.pkExpenseId,
    this.productName,
    this.skUserId,
    this.expenseAmount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
    timeOfUse: json["time_of_use"] != null ? DateTime.parse(json["time_of_use"]) : null,
    pkExpenseId: json["pk_expense_id"],
    productName: json["product_name"],
    skUserId: json["sk_user_id"],
    expenseAmount: json["expense_amount"],
  );

  Map<String, dynamic> toJson() => {
    "time_of_use": timeOfUse?.toIso8601String(),
    "pk_expense_id": pkExpenseId,
    "product_name": productName,
    "sk_user_id": skUserId,
    "expense_amount": expenseAmount,
  };
}
