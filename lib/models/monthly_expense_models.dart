import 'dart:convert';

MonthlyExpenseModel monthlyExpenseModelFromJson(String str) =>
    MonthlyExpenseModel.fromJson(json.decode(str));

String monthlyExpenseModelToJson(MonthlyExpenseModel data) =>
    json.encode(data.toJson());

class MonthlyExpenseModel {
  String? statusCode;
  String? message;
  ExpenseSummary? data;

  MonthlyExpenseModel({
    this.statusCode,
    this.message,
    this.data,
  });

  factory MonthlyExpenseModel.fromJson(Map<String, dynamic> json) =>
      MonthlyExpenseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] != null
            ? ExpenseSummary.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class ExpenseSummary {
  double? totalExpense;
  Map<String, double>? expenseDistribution;

  ExpenseSummary({
    this.totalExpense,
    this.expenseDistribution,
  });

  factory ExpenseSummary.fromJson(Map<String, dynamic> json) => ExpenseSummary(
    totalExpense: json["total_expense"]?.toDouble(),
    expenseDistribution: Map<String, double>.from(json["expense_distribution"]
        .map((key, value) => MapEntry(key, value.toDouble()))),
  );

  Map<String, dynamic> toJson() => {
    "total_expense": totalExpense,
    "expense_distribution": expenseDistribution,
  };
}
