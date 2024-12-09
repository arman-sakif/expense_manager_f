import 'dart:convert';

class ProfileModel {
  String statusCode;
  Body body;

  ProfileModel({
    required this.statusCode,
    required this.body,
  });

  factory ProfileModel.fromRawJson(String str) => ProfileModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    statusCode: json["statusCode"],
    body: Body.fromJson(json["data"]), // Adjusted to map "data" to the Body
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "data": body.toJson(), // Adjusted to map "data" to the Body
  };
}

class Body {
  String email;
  String name;
  String gender;
  String pkUserId;
  int status;

  Body({
    required this.email,
    required this.name,
    required this.gender,
    required this.pkUserId,
    required this.status,
  });

  factory Body.fromRawJson(String str) => Body.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    email: json["email"],
    name: json["name"],
    gender: json["gender"],
    pkUserId: json["pk_user_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "gender": gender,
    "pk_user_id": pkUserId,
    "status": status,
  };
}
