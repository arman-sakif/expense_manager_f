import 'dart:convert';

// Convert JSON to ViewGrowthListModel
ViewGrowthListModel viewGrowthListModelFromJson(String str) {
  if (str.isEmpty) {
    throw Exception('Empty JSON string');
  }
  final jsonData = json.decode(str);
  if (jsonData == null || jsonData is! Map<String, dynamic>) {
    throw Exception('Invalid JSON data');
  }
  return ViewGrowthListModel.fromJson(jsonData);
}

// Convert ViewGrowthListModel to JSON
String viewGrowthListModelToJson(ViewGrowthListModel data) => json.encode(data.toJson());

// Main model class
class ViewGrowthListModel {
  String statusCode;
  Body body;

  ViewGrowthListModel({
    required this.statusCode,
    required this.body,
  });

  factory ViewGrowthListModel.fromJson(Map<String, dynamic> json) {
    return ViewGrowthListModel(
      statusCode: json["statusCode"] ?? '',
      body: json["body"] != null ? Body.fromJson(json["body"]) : Body.empty(),
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "body": body.toJson(),
  };
}

// Body class
class Body {
  String pkChildId;
  String? numberOfStillbirth;
  String fatherStatus;
  String numberOfBirth;
  String genderFemale;
  String fatherId;
  String childType;
  String birthId;
  DayData? day45;
  String birthDate;
  String childVariety;
  DateTime createdAt;
  String childStatus;
  String motherId;
  String childName;
  DayData? day0;
  String gender;
  String skUserId;
  String childWeight;
  DateTime updatedAt;
  String genderMale;
  String childManagementId;
  String childDeleteFlag;
  Images images;
  DayData? day30;
  DayData? day15;

  Body({
    required this.pkChildId,
    this.numberOfStillbirth,
    required this.fatherStatus,
    required this.numberOfBirth,
    required this.genderFemale,
    required this.fatherId,
    required this.childType,
    required this.birthId,
    this.day45,
    required this.birthDate,
    required this.childVariety,
    required this.createdAt,
    required this.childStatus,
    required this.motherId,
    required this.childName,
    this.day0,
    required this.gender,
    required this.skUserId,
    required this.childWeight,
    required this.updatedAt,
    required this.genderMale,
    required this.childManagementId,
    required this.childDeleteFlag,
    required this.images,
    this.day30,
    this.day15,
  });

  factory Body.empty() => Body(
    pkChildId: '',
    fatherStatus: '',
    numberOfBirth: '',
    genderFemale: '',
    fatherId: '',
    childType: '',
    birthId: '',
    birthDate: '',
    childVariety: '',
    createdAt: DateTime.now(),
    childStatus: '',
    motherId: '',
    childName: '',
    gender: '',
    skUserId: '',
    childWeight: '',
    updatedAt: DateTime.now(),
    genderMale: '',
    childManagementId: '',
    childDeleteFlag: '',
    images: Images.empty(),
  );

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      pkChildId: json["pk_child_id"] ?? '',
      numberOfStillbirth: json["number_of_stillbirth"],
      fatherStatus: json["father_status"] ?? '',
      numberOfBirth: json["number_of_birth"] ?? '',
      genderFemale: json["gender_female"] ?? '',
      fatherId: json["father_id"] ?? '',
      childType: json["child_type"] ?? '',
      birthId: json["birth_id"] ?? '',
      day45: json["day45"] != null ? DayData.fromJson(json["day45"]) : null,
      birthDate: json["birth_date"] ?? '',
      childVariety: json["child_variety"] ?? '',
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
      childStatus: json["child_status"] ?? '',
      motherId: json["mother_id"] ?? '',
      childName: json["child_name"] ?? '',
      day0: json["day0"] != null ? DayData.fromJson(json["day0"]) : null,
      gender: json["gender"] ?? '',
      skUserId: json["sk_user_id"] ?? '',
      childWeight: json["child_weight"] ?? '',
      updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
      genderMale: json["gender_male"] ?? '',
      childManagementId: json["child_management_id"] ?? '',
      childDeleteFlag: json["child_delete_flag"] ?? '',
      images: json["images"] != null ? Images.fromJson(json["images"]) : Images.empty(),
      day30: json["day30"] != null ? DayData.fromJson(json["day30"]) : null,
      day15: json["day15"] != null ? DayData.fromJson(json["day15"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "pk_child_id": pkChildId,
    "number_of_stillbirth": numberOfStillbirth,
    "father_status": fatherStatus,
    "number_of_birth": numberOfBirth,
    "gender_female": genderFemale,
    "father_id": fatherId,
    "child_type": childType,
    "birth_id": birthId,
    "day45": day45?.toJson(),
    "birth_date": birthDate,
    "child_variety": childVariety,
    "created_at": createdAt.toIso8601String(),
    "child_status": childStatus,
    "mother_id": motherId,
    "child_name": childName,
    "day0": day0?.toJson(),
    "gender": gender,
    "sk_user_id": skUserId,
    "child_weight": childWeight,
    "updated_at": updatedAt.toIso8601String(),
    "gender_male": genderMale,
    "child_management_id": childManagementId,
    "child_delete_flag": childDeleteFlag,
    "images": images.toJson(),
    "day30": day30?.toJson(),
    "day15": day15?.toJson(),
  };
}

// DayData class to handle 'day0', 'day15', 'day30', and 'day45'
class DayData {
  String? date;
  String? image;
  String? weight;
  String? comment;

  DayData({this.date, this.image, this.weight, this.comment});

  factory DayData.fromJson(Map<String, dynamic> json) {
    return DayData(
      date: json["date"] ?? '',
      image: json["image"] ?? '',
      weight: json["weight"] ?? '',
      comment: json["comment"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "date": date,
    "image": image,
    "weight": weight,
    "comment": comment,
  };
}

// Images class to handle image paths
class Images {
  String path1;
  String path2;
  String path3;

  Images({
    required this.path1,
    required this.path2,
    required this.path3,
  });

  factory Images.empty() => Images(
    path1: '',
    path2: '',
    path3: '',
  );

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      path1: json["path1"] ?? '',
      path2: json["path2"] ?? '',
      path3: json["path3"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "path1": path1,
    "path2": path2,
    "path3": path3,
  };
}
