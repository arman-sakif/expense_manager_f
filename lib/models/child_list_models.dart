import 'dart:convert';

ChildListModel childListModelFromJson(String str) {
  if (str.isEmpty) {
    throw Exception('Empty JSON string');
  }

  final jsonData = json.decode(str);
  if (jsonData == null || jsonData is! Map<String, dynamic>) {
    throw Exception('Invalid JSON data');
  }
  return ChildListModel.fromJson(jsonData);
}

String childListModelToJson(ChildListModel data) => json.encode(data.toJson());

class ChildListModel {
  String statusCode;
  List<Body> body;

  ChildListModel({
    required this.statusCode,
    required this.body,
  });

  factory ChildListModel.fromJson(Map<String, dynamic> json) {
    return ChildListModel(
      statusCode: json["statusCode"] ?? '',
      body: json["body"] != null ? List<Body>.from(json["body"].map((x) => Body.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "body": List<dynamic>.from(body.map((x) => x.toJson())),
  };
}

class Body {
  String pkChildId;
  String childVariety;
  String birthDate;
  DateTime createdAt;
  String childStatus;
  String motherId;
  String fatherStatus;
  String childName;
  Day0? day0;
  String gender;
  String skUserId;
  String childWeight;
  DateTime updatedAt;
  String fatherId;
  String child_delete_flag;
  String childType;
  dynamic shopId;
  Images images;
  dynamic day30;
  dynamic day15;
  String birthId;
  dynamic day45;
  String numberOfBirth;
  String numberOfStillbirth;
  String genderMale;
  String genderFemale;
  String childManagementId; // New field
  // New fields
  List<String>? matingDate;
  String? matingEndDate;
  String matingFlag;

  Body({
    required this.pkChildId,
    required this.childVariety,
    required this.birthDate,
    required this.createdAt,
    required this.childStatus,
    required this.motherId,
    required this.fatherStatus,
    required this.childName,
    this.day0,
    required this.gender,
    required this.skUserId,
    required this.childWeight,
    required this.updatedAt,
    required this.fatherId,
    required this.child_delete_flag,
    required this.childType,
    this.shopId,
    required this.images,
    this.day30,
    this.day15,
    required this.birthId,
    this.day45,
    required this.numberOfBirth,
    required this.numberOfStillbirth,
    required this.genderMale,
    required this.genderFemale,
    required this.childManagementId, // New field
    this.matingDate,        // New field
    this.matingEndDate,     // New field
    required this.matingFlag, // New field
  });

  factory Body.fromJson(Map<String, dynamic> json) {
    // print('Parsing Body: $json'); // Log the JSON data being parsed

    return Body(
      pkChildId: json["pk_child_id"] ?? '',
      childVariety: json["child_variety"] ?? '',
      birthDate: json["birth_date"] ?? '',
      createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
      childStatus: json["child_status"] ?? '',
      motherId: json["mother_id"] ?? '',
      fatherStatus: json["father_status"] ?? '',
      childName: json["child_name"] ?? '',
      day0: json["day0"] != null ? Day0.fromJson(json["day0"]) : null,
      gender: json["gender"] ?? '',
      skUserId: json["sk_user_id"] ?? '',
      childWeight: json["child_weight"] ?? '',
      updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
      fatherId: json["father_id"] ?? '',
      child_delete_flag: json["child_delete_flag"] ?? '',
      childType: json["child_type"] ?? '',
      shopId: json["shop_id"],
      images: json["images"] != null ? Images.fromJson(json["images"]) : Images(path1: '', path2: '', path3: ''),
      day30: json["day30"],
      day15: json["day15"],
      birthId: json["birth_id"] ?? '',
      day45: json["day45"],
      numberOfBirth: json["number_of_birth"] ?? '',
      numberOfStillbirth: json["number_of_stillbirth"] ?? '',
      genderMale: json["gender_male"] ?? '',
      genderFemale: json["gender_female"] ?? '',
      childManagementId: json["child_management_id"] ?? '', // New field
      matingDate: json["mating_date"] != null ? List<String>.from(json["mating_date"]) : null,
      matingEndDate: json["mating_end_date"],
      matingFlag: json["mating_flag"] ?? '0',
    );
  }

  Map<String, dynamic> toJson() => {
    "pk_child_id": pkChildId,
    "child_variety": childVariety,
    "birth_date": birthDate,
    "created_at": createdAt.toIso8601String(),
    "child_status": childStatus,
    "mother_id": motherId,
    "father_status": fatherStatus,
    "child_name": childName,
    "day0": day0?.toJson(),
    "gender": gender,
    "sk_user_id": skUserId,
    "child_weight": childWeight,
    "updated_at": updatedAt.toIso8601String(),
    "father_id": fatherId,
    "child_delete_flag": child_delete_flag,
    "child_type": childType,
    "shop_id": shopId,
    "images": images.toJson(),
    "day30": day30,
    "day15": day15,
    "birth_id": birthId,
    "day45": day45,
    "number_of_birth": numberOfBirth,
    "number_of_stillbirth": numberOfStillbirth,
    "gender_male": genderMale,
    "gender_female": genderFemale,
    "child_management_id": childManagementId, // New field
    "mating_date": matingDate,  // New field
    "mating_end_date": matingEndDate, // New field
    "mating_flag": matingFlag,   // New field
  };
}

class Day0 {
  String weight;
  String image;

  Day0({
    required this.weight,
    required this.image,
  });

  factory Day0.fromJson(Map<String, dynamic> json) {
    return Day0(
      weight: json["weight"] ?? '',
      image: json["image"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "weight": weight,
    "image": image,
  };
}

class Images {
  String path1;
  String path2;
  String path3;

  Images({
    required this.path1,
    required this.path2,
    required this.path3,
  });

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

class RetireInformation {
  String information;
  String retireDate;
  String reason;
  String saleInformation;
  String zip;
  String domicile;

  RetireInformation({
    required this.information,
    required this.retireDate,
    required this.reason,
    required this.saleInformation,
    required this.zip,
    required this.domicile,
  });

  factory RetireInformation.fromJson(Map<String, dynamic> json) => RetireInformation(
    information: json["information"] ?? '',
    retireDate: json["retire_date"] ?? '',
    reason: json["reason"] ?? '',
    saleInformation: json["sale_information"] ?? '',
    zip: json["zip"] ?? '',
    domicile: json["domicile"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "information": information,
    "retire_date": retireDate,
    "reason": reason,
    "sale_information": saleInformation,
    "zip": zip,
    "domicile": domicile,
  };

  @override
  String toString() {
    return 'RetireInformation(information: $information, retireDate: $retireDate, reason: $reason, saleInformation: $saleInformation, zip: $zip, domicile: $domicile)';
  }
}
