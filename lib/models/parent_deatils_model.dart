import 'dart:convert';

ParentDetailsModel parentDetailsModelFromJson(String str) => ParentDetailsModel.fromJson(json.decode(str));

String parentDetailsModelToJson(ParentDetailsModel data) => json.encode(data.toJson());


class ParentDetailsModel {
  String? statusCode;
  Body? body;

  ParentDetailsModel({this.statusCode, this.body});

  factory ParentDetailsModel.fromJson(Map<String, dynamic> json) {
    return ParentDetailsModel(
      statusCode: json['statusCode'],
      body: json['body'] != null ? Body.fromJson(json['body']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = this.statusCode;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Body {
  String? pedigreeGrp;
  String? birthDate;
  String? hairType;
  String? petDesc;
  String? pedigreeNumber;
  Map<String, String>? geneticDisease;
  String? petName;
  String? petWeight;
  String? petType;
  String? coatColor;
  String? petStatus;
  String? createdAt;
  String? microchipNo;
  String? gender;
  String skUserId;
  String? petVariety;
  String? updatedAt;
  String pkParentId;
  String? shopId;
  String? managementNumber;
  Images? images;
  RetireInformation? retireInformation;
  String? parentDeleteFlag;
  ChildrenInfo? childrenInfo;

  /// pedigree info of new update
  /// owner_post_code
  String? ownershipDate;
  String? ownershipType;
  String? ownerName;
  String? ownerAddress;
  String? ownerPostCode;
  String? animalHandleNumber;


  Body({
    this.pedigreeGrp,
    this.birthDate,
    this.hairType,
    this.petDesc,
    this.pedigreeNumber,
    this.geneticDisease,
    this.petName,
    this.petWeight,
    this.petType,
    this.coatColor,
    this.petStatus,
    this.createdAt,
    this.microchipNo,
    this.gender,
    required this.skUserId,
    this.petVariety,
    this.updatedAt,
    required this.pkParentId,
    this.parentDeleteFlag,
    this.shopId,
    this.managementNumber,
    this.images,
    this.retireInformation,
    this.childrenInfo,
    this.ownershipDate,
    this.ownershipType,
    this.ownerName,
    this.ownerAddress,
    this.ownerPostCode,
    this.animalHandleNumber,

  });

  factory Body.fromJson(Map<String, dynamic> json) {
    return Body(
      pedigreeGrp: json['pedigree_grp'],
      birthDate: json['birth_date'],
      hairType: json['hair_type'],
      petDesc: json['pet_desc'],
      pedigreeNumber: json['pedigree_number'],
      geneticDisease: json['genetic_disease'] != null
          ? Map<String, String>.from(json['genetic_disease'])
          : null,
      petName: json['pet_name'],
      petWeight: json['pet_weight'],
      petType: json['pet_type'],
      coatColor: json['coat_color'],
      petStatus: json['pet_status'],
      createdAt: json['created_at'],
      microchipNo: json['microchip_no'],
      gender: json['gender'],
      skUserId: json['sk_user_id'],
      petVariety: json['pet_variety'],
      updatedAt: json['updated_at'],
      pkParentId: json['pk_parent_id'],
      parentDeleteFlag: json['parent_delete_flag'],
      shopId: json['shop_id'],

      // new pedigree data
      ownershipDate: json['ownership_date'],
      ownershipType: json['ownership_type'],
      ownerName: json['owner_name'],
      ownerAddress: json['owner_address'],
      ownerPostCode: json['owner_post_code'],
      animalHandleNumber: json['animal_handle_no'],



      managementNumber: json['management_number'],
      images: json['images'] != null ? Images.fromJson(json['images']) : null,
      retireInformation: json['retire_information'] is Map<String, dynamic>
          ? RetireInformation.fromJson(json['retire_information'])
          : null,
      childrenInfo: json['children_info'] != null
          ? ChildrenInfo.fromJson(json['children_info'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pedigree_grp'] = this.pedigreeGrp;
    data['birth_date'] = this.birthDate;
    data['hair_type'] = this.hairType;
    data['pet_desc'] = this.petDesc;
    data['pedigree_number'] = this.pedigreeNumber;
    if (this.geneticDisease != null) {
      data['genetic_disease'] = this.geneticDisease;
    }
    data['pet_name'] = this.petName;
    data['pet_weight'] = this.petWeight;
    data['pet_type'] = this.petType;
    data['coat_color'] = this.coatColor;
    data['pet_status'] = this.petStatus;
    data['created_at'] = this.createdAt;
    data['microchip_no'] = this.microchipNo;
    data['gender'] = this.gender;
    data['sk_user_id'] = this.skUserId;
    data['pet_variety'] = this.petVariety;
    data['updated_at'] = this.updatedAt;
    data['pk_parent_id'] = this.pkParentId;
    data['parent_delete_flag'] = this.parentDeleteFlag;
    data['shop_id'] = this.shopId;

    data['ownership_date'] = this.ownershipDate;
    data['ownership_type'] = this.ownershipType;
    data['owner_name'] = this.ownerName;
    data['owner_address'] = this.ownerAddress;
    data['owner_post_code'] = this.ownerPostCode;
    data['animal_handle_no'] = this.animalHandleNumber;


    data['management_number'] = this.managementNumber;
    if (this.images != null) {
      data['images'] = this.images!.toJson();
    }
    if (this.retireInformation != null) {
      data['retire_information'] = this.retireInformation!.toJson();
    }
    if (this.childrenInfo != null) {
      data['children_info'] = this.childrenInfo!.toJson();
    }
    return data;
  }
}

class Images {
  String? path1;
  String? path2;
  String? path3;

  Images({this.path1, this.path2, this.path3});

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      path1: json['path1'],
      path2: json['path2'],
      path3: json['path3'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['path1'] = this.path1;
    data['path2'] = this.path2;
    data['path3'] = this.path3;
    return data;
  }
}

class RetireInformation {
  String? information;
  String? retireDate;
  String? reason;
  SaleInformation? saleInformation;

  RetireInformation({
    this.information,
    this.retireDate,
    this.reason,
    this.saleInformation,
  });

  factory RetireInformation.fromJson(Map<String, dynamic> json) => RetireInformation(
    information: json["information"],
    retireDate: json["retire_date"],
    reason: json["reason"],
    saleInformation: json["sale_information"] != null ? SaleInformation.fromJson(json["sale_information"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "information": information,
    "retire_date": retireDate,
    "reason": reason,
    "sale_information": saleInformation?.toJson(),
  };
}

class SaleInformation {
  String? zip;
  String? name;
  String? residence;

  SaleInformation({
    this.zip,
    this.name,
    this.residence,
  });

  factory SaleInformation.fromJson(Map<String, dynamic> json) => SaleInformation(
    zip: json["zip"],
    name: json["name"],
    residence: json["residence"],
  );

  Map<String, dynamic> toJson() => {
    "zip": zip,
    "name": name,
    "residence": residence,
  };
}

class ChildrenInfo {
  String? parentAttribute;
  String? parentId;
  String? totalBirth;
  List<Child>? children;

  ChildrenInfo({this.parentAttribute, this.parentId, this.totalBirth, this.children});

  factory ChildrenInfo.fromJson(Map<String, dynamic> json) {
    return ChildrenInfo(
      parentAttribute: json['parent_attribute'],
      parentId: json['parent_id'],
      totalBirth: json['total_birth'],
      children: json['children'] != null
          ? List<Child>.from(json['children'].map((x) => Child.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['parent_attribute'] = this.parentAttribute;
    data['parent_id'] = this.parentId;
    data['total_birth'] = this.totalBirth;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Child {
  String? pkChildId;
  String? pkChildUserId;
  String? dateOfBirth;
  String? childName;
  String? growthStatus;

  Child({this.pkChildId,this.pkChildUserId, this.dateOfBirth, this.childName, this.growthStatus});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      pkChildId: json['pk_child_id'],
      pkChildUserId: json['sk_user_id'],
      dateOfBirth: json['date_of_birth'],
      childName: json['child_name'],
      growthStatus: json['growth_status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['pk_child_id'] = this.pkChildId;
    data['sk_user_id'] = this.pkChildUserId;
    data['date_of_birth'] = this.dateOfBirth;
    data['child_name'] = this.childName;
    data['growth_status'] = this.growthStatus;
    return data;
  }
}
