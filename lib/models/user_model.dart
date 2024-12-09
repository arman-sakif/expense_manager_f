import 'dart:convert';

// Function to parse JSON string to UserModel
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// Function to convert UserModel to JSON string
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  Body? body;

  UserModel({this.body});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    body: json["body"] != null ? Body.fromJson(json["body"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "body": body?.toJson(), // Use null-aware operator to handle null values
  };
}

class Body {
  String userId;
  String idToken;
  String accessToken;

  Body({required this.userId, required this.idToken, required this.accessToken});

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    userId: json["user_id"], // Correctly map user_id
    idToken: json["id_token"], // Correctly map id_token
    accessToken: json["access_token"], // Correctly map id_token
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId, // Correctly map user_id
    "id_token": idToken, // Correctly map id_token
    "access_token": accessToken, // Correctly map id_token
  };
}