import 'dart:convert';

ChildDetailsModel childDetailsModelFromJson(String str) => ChildDetailsModel.fromJson(json.decode(str));

String childDetailsModelToJson(ChildDetailsModel data) => json.encode(data.toJson());

class ChildDetailsModel {
  String statusCode;
  Body body;

  ChildDetailsModel({
    required this.statusCode,
    required this.body,
  });

  factory ChildDetailsModel.fromJson(Map<String, dynamic> json) => ChildDetailsModel(
    statusCode: json["statusCode"],
    body: Body.fromJson(json["body"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "body": body.toJson(),
  };

  @override
  String toString() {
    return 'ChildDetailsModel(statusCode: $statusCode, body: $body)';
  }
}

class Body {
  Child child;
  Ther mother;
  Ther father;

  Body({
    required this.child,
    required this.mother,
    required this.father,
  });

  factory Body.fromJson(Map<String, dynamic> json) => Body(
    child: Child.fromJson(json["child"] ?? {}),
    mother: Ther.fromJson(json["mother"] ?? {}),
    father: Ther.fromJson(json["father"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "child": child.toJson(),
    "mother": mother.toJson(),
    "father": father.toJson(),
  };

  @override
  String toString() {
    return 'Body(child: $child, mother: $mother, father: $father)';
  }
}

class Child {
  String pkChildId;
  String birthDate;
  List<String>? matingDate; // List of dates for mating
  String? matingEndDate; // Nullable end date for mating
  String matingFlag;  String childVariety;
  DateTime createdAt;
  String childStatus;
  String childName;
  Day day0;
  String fatherStatus;
  String motherId;
  String gender;
  String skUserId;
  String childWeight;
  DateTime updatedAt;
  String childDeleteFlag;
  String fatherId;
  String childType;
  dynamic shopId;
  Images? images;
  Day day30;
  Day day15;
  String birthId;
  Day day45;
  String numberOfBirth;
  String numberOfStillbirth;
  String genderMale;
  String genderFemale;
  String childManagementId;

  Child({
    required this.pkChildId,
    required this.birthDate,
    this.matingDate,
    this.matingEndDate,
    required this.matingFlag,
    required this.childVariety,
    required this.createdAt,
    required this.childStatus,
    required this.childName,
    required this.day0,
    required this.fatherStatus,
    required this.motherId,
    required this.gender,
    required this.skUserId,
    required this.childWeight,
    required this.updatedAt,
    required this.childDeleteFlag,
    required this.fatherId,
    required this.childType,
    this.shopId,
    this.images,
    required this.day30,
    required this.day15,
    required this.birthId,
    required this.day45,
    required this.numberOfBirth,
    required this.numberOfStillbirth,
    required this.genderMale,
    required this.genderFemale,
    required this.childManagementId,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    pkChildId: json["pk_child_id"] ?? '',
    birthDate: json["birth_date"] ?? '',
    childVariety: json["child_variety"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toIso8601String()),
    childStatus: json["child_status"] ?? '',
    childName: json["child_name"] ?? '',
    day0: Day.fromJson(json["day0"] ?? {}),
    fatherStatus: json["father_status"] ?? '',
    motherId: json["mother_id"] ?? '',
    gender: json["gender"] ?? '',
    skUserId: json["sk_user_id"] ?? '',
    childWeight: json["child_weight"] ?? '',
    updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now().toIso8601String()),
    childDeleteFlag: json["child_delete_flag"] ?? '',
    fatherId: json["father_id"] ?? '',
    childType: json["child_type"] ?? '',
    shopId: json["shop_id"],
    images: json['images'] != null ? Images.fromJson(json['images']) : null,
    day30: Day.fromJson(json["day30"] ?? {}),
    day15: Day.fromJson(json["day15"] ?? {}),
    birthId: json["birth_id"] ?? '',
    day45: Day.fromJson(json["day45"] ?? {}),
    numberOfBirth: json["number_of_birth"] ?? '',
    numberOfStillbirth: json["number_of_stillbirth"] ?? '',
    genderMale: json["gender_male"] ?? '',
    genderFemale: json["gender_female"] ?? '',
    childManagementId: json["child_management_id"] ?? '',
    matingDate: json["mating_date"] != null ? List<String>.from(json["mating_date"]) : null,
    matingEndDate: json["mating_end_date"],
    matingFlag: json["mating_flag"] ?? '1',
  );

  Map<String, dynamic> toJson() => {
    "pk_child_id": pkChildId,
    "birth_date": birthDate,
    "mating_date": matingDate,
    "mating_end_date": matingEndDate,
    "mating_flag": matingFlag,
    "child_variety": childVariety,
    "created_at": createdAt.toIso8601String(),
    "child_status": childStatus,
    "child_name": childName,
    "day0": day0.toJson(),
    "father_status": fatherStatus,
    "mother_id": motherId,
    "gender": gender,
    "sk_user_id": skUserId,
    "child_weight": childWeight,
    "updated_at": updatedAt.toIso8601String(),
    "child_delete_flag": childDeleteFlag,
    "father_id": fatherId,
    "child_type": childType,
    "shop_id": shopId,
    "images": images?.toJson(),
    "day30": day30.toJson(),
    "day15": day15.toJson(),
    "birth_id": birthId,
    "day45": day45.toJson(),
    "number_of_birth": numberOfBirth,
    "number_of_stillbirth": numberOfStillbirth,
    "gender_male": genderMale,
    "gender_female": genderFemale,
    "child_management_id": childManagementId,

  };

  @override
  String toString() {
    return 'Child(pkChildId: $pkChildId, birthDate: $birthDate, matingDate: $matingDate, matingEndDate: $matingEndDate, matingFlag: $matingFlag, childVariety: $childVariety, createdAt: $createdAt, childStatus: $childStatus, childName: $childName, day0: $day0, fatherStatus: $fatherStatus, motherId: $motherId, gender: $gender, skUserId: $skUserId, childWeight: $childWeight, updatedAt: $updatedAt, deleteFlag: $childDeleteFlag, fatherId: $fatherId, childType: $childType, shopId: $shopId, images: $images, day30: $day30, day15: $day15, birthId: $birthId, day45: $day45, numberOfBirth: $numberOfBirth, numberOfStillbirth: $numberOfStillbirth, genderMale: $genderMale, genderFemale: $genderFemale)';
  }
}

class Day {
  String weight;
  String image;
  String comment;
  String date;

  Day({
    required this.weight,
    required this.image,
    required this.comment,
    required this.date,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    weight: json["weight"] ?? '',
    image: json["image"] ?? '',
    comment: json["comment"] ?? '',
    date: json["date"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "weight": weight,
    "image": image,
    "comment": comment,
    "date": date,
  };

  @override
  String toString() {
    return 'Day(weight: $weight, image: $image, comment: $comment, date: $date)';
  }
}

class Ther {
  String pedigreeGrp;
  String birthDate;
  String matingDate;
  String microchipNo;
  DateTime createdAt;
  String petDesc;
  String gender;
  String skUserId;
  String petVariety;
  DateTime updatedAt;
  String petName;
  String pkParentId;
  String shopId;
  String petWeight;
  String parentDeleteFlag;
  String managementNumber;
  Images images;
  String petType;
  String petStatus;
  String coatColor;
  String hairType;
  String pedigreeNumber;
  Map<String, String>? geneticDisease;
  RetireInformation? retireInformation;
  String parentChildren;

  Ther({
    required this.pedigreeGrp,
    required this.birthDate,
    required this.matingDate,
    required this.microchipNo,
    required this.createdAt,
    required this.petDesc,
    required this.gender,
    required this.skUserId,
    required this.petVariety,
    required this.updatedAt,
    required this.petName,
    required this.pkParentId,
    required this.shopId,
    required this.petWeight,
    required this.parentDeleteFlag,
    required this.managementNumber,
    required this.images,
    required this.petType,
    required this.petStatus,
    required this.coatColor,
    required this.hairType,
    required this.pedigreeNumber,
    this.geneticDisease,
    this.retireInformation,
    required this.parentChildren,
  });

  factory Ther.fromJson(Map<String, dynamic> json) => Ther(
    pedigreeGrp: json["pedigree_grp"] ?? '',
    birthDate: json["birth_date"] ?? '',
    matingDate: json["mating_date"] ?? '',
    microchipNo: json["microchip_no"] ?? '',
    createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toIso8601String()),
    petDesc: json["pet_desc"] ?? '',
    gender: json["gender"] ?? '',
    skUserId: json["sk_user_id"] ?? '',
    petVariety: json["pet_variety"] ?? '',
    updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now().toIso8601String()),
    petName: json["pet_name"] ?? '',
    pkParentId: json["pk_parent_id"] ?? '',
    shopId: json["shop_id"] ?? '',
    petWeight: json["pet_weight"] ?? '',

    parentDeleteFlag: json["parent_delete_flag"] ?? '',
    managementNumber: json["management_number"] ?? '',
    images: Images.fromJson(json["images"] ?? {}),
    petType: json["pet_type"] ?? '',
    petStatus: json["pet_status"] ?? '',
    coatColor: json["coat_color"] ?? '',
    hairType: json["hair_type"] ?? '',
    pedigreeNumber: json["pedigree_number"] ?? '',
    geneticDisease: json['genetic_disease'] != null
        ? Map<String, String>.from(json['genetic_disease'])
        : null,
    retireInformation: (json["retire_information"] is Map<String, dynamic>)
        ? RetireInformation.fromJson(json["retire_information"])
        : null,
    parentChildren: json["number_of_child"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "pedigree_grp": pedigreeGrp,
    "birth_date": birthDate,
    "mating_date": matingDate,
    "microchip_no": microchipNo,
    "created_at": createdAt.toIso8601String(),
    "pet_desc": petDesc,
    "gender": gender,
    "sk_user_id": skUserId,
    "pet_variety": petVariety,
    "updated_at": updatedAt.toIso8601String(),
    "pet_name": petName,
    "pk_parent_id": pkParentId,
    "shop_id": shopId,
    "pet_weight": petWeight,
    "parent_delete_flag": parentDeleteFlag,
    "management_number": managementNumber,
    "images": images.toJson(),
    "pet_type": petType,
    "pet_status": petStatus,
    "coat_color": coatColor,
    "hair_type": hairType,
    "pedigree_number": pedigreeNumber,
    if (geneticDisease != null)
      "genetic_disease": geneticDisease,
    if (retireInformation != null)
      "retire_information": retireInformation!.toJson(),
    "number_of_child": parentChildren,
  };

  @override
  String toString() {
    return 'Ther(pedigreeGrp: $pedigreeGrp, birthDate: $birthDate, microchipNo: $microchipNo, createdAt: $createdAt, petDesc: $petDesc, gender: $gender, skUserId: $skUserId, petVariety: $petVariety, updatedAt: $updatedAt, petName: $petName, pkParentId: $pkParentId, shopId: $shopId, petWeight: $petWeight, parentDeleteFlag: $parentDeleteFlag, managementNumber: $managementNumber, images: $images, petType: $petType, petStatus: $petStatus, coatColor: $coatColor, hairType: $hairType, pedigreeNumber: $pedigreeNumber, geneticDisease: $geneticDisease, retireInformation: $retireInformation)';
  }
}

class Images {
  String? path1;
  String? path2;
  String? path3;

  Images({
     this.path1,
     this.path2,
     this.path3,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    path1: json["path1"],
    path2: json["path2"],
    path3: json["path3"],
  );

  Map<String, dynamic> toJson() => {
    "path1": path1,
    "path2": path2,
    "path3": path3,
  };

  @override
  String toString() {
    return 'Images(path1: $path1, path2: $path2, path3: $path3)';
  }
}

class RetireInformation {
  String information;
  String retireDate;
  String reason;
  SaleInformation saleInformation;

  RetireInformation({
    required this.information,
    required this.retireDate,
    required this.reason,
    required this.saleInformation,
  });

  factory RetireInformation.fromJson(Map<String, dynamic> json) => RetireInformation(
    information: json["information"] ?? '',
    retireDate: json["retire_date"] ?? '',
    reason: json["reason"] ?? '',
    saleInformation: SaleInformation.fromJson(json["sale_information"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "information": information,
    "retire_date": retireDate,
    "reason": reason,
    "sale_information": saleInformation.toJson(),
  };

  @override
  String toString() {
    return 'RetireInformation(information: $information, retireDate: $retireDate, reason: $reason, saleInformation: $saleInformation)';
  }
}

class SaleInformation {
  String zip;
  String name;
  String residence;

  SaleInformation({
    required this.zip,
    required this.name,
    required this.residence,
  });

  factory SaleInformation.fromJson(Map<String, dynamic> json) => SaleInformation(
    zip: json["zip"] ?? '',
    name: json["name"] ?? '',
    residence: json["residence"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "zip": zip,
    "name": name,
    "residence": residence,
  };

  @override
  String toString() {
    return 'SaleInformation(zip: $zip, name: $name, residence: $residence)';
  }
}
