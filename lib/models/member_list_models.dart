import 'dart:convert';

class MemberModel {
  String statusCode;
  List<Body> body;

  MemberModel({
    required this.statusCode,
    required this.body,
  });

  factory MemberModel.fromRawJson(String str) => MemberModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
    statusCode: json["statusCode"],
    body: List<Body>.from(json["body"].map((x) => Body.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "body": List<dynamic>.from(body.map((x) => x.toJson())),
  };
}

class Body {
  String? updatedAt;
  String? profileImg;
  String? deleteFlag;
  String? location;
  String? createdAt;
  String? role;
  String? pkUserId;
  String? status;
  String? skId;
  String? email;
  String? userName;
  String? phone;
  String? companyName;
  String? parkId;
  String? userVerifyFlag;

  Body({
    this.updatedAt,
    this.profileImg,
    this.deleteFlag,
    this.location,
    this.createdAt,
    this.role,
    this.pkUserId,
    this.status,
    this.skId,
    this.email,
    this.userName,
    this.phone,
    this.companyName,
    this.parkId,
    this.userVerifyFlag,
  });

  factory Body.fromRawJson(String str) => Body.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    updatedAt: json["updated_at"],
    profileImg: json["profile_img"],
    deleteFlag: json["delete_flag"],
    location: json["location"],
    createdAt: json["created_at"],
    role: json["role"],
    pkUserId: json["pk_user_id"],
    status: json["status"],
    skId: json["sk_id"],
    email: json["email"],
    userName: json["user_name"],
    phone: json["phone"],
    companyName: json["company_name"],
    parkId: json["park_id"],
    userVerifyFlag: json["user_verify_flag"],
  );

  Map<String, dynamic> toJson() => {
    "updated_at": updatedAt,
    "profile_img": profileImg,
    "delete_flag": deleteFlag,
    "location": location,
    "created_at": createdAt,
    "role": role,
    "pk_user_id": pkUserId,
    "status": status,
    "sk_id": skId,
    "email": email,
    "user_name": userName,
    "phone": phone,
    "company_name": companyName,
    "park_id": parkId,
    "user_verify_flag": userVerifyFlag,
  };
}
