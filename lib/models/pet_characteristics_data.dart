class PetCharacteristicsData {
  String statusCode;
  Data data;

  PetCharacteristicsData({
    required this.statusCode,
    required this.data,
  });

  factory PetCharacteristicsData.fromJson(Map<String, dynamic> json) {
    return PetCharacteristicsData(
      statusCode: json['statusCode'],
      data: Data.fromJson(json['data'] ?? {}),
    );
  }
}

class Data {
  // Fields related to cats
  Map<String, String> catDisease;
  Map<String, String> catCoat;
  Map<String, String> catHair;
  Map<String, String> catVariety;
  Map<String, String> catPedigreeGroup;

  // Fields related to dogs
  Map<String, String> dogDisease;
  Map<String, String> dogCoat;
  Map<String, String> dogHair;
  Map<String, String> dogVariety;
  Map<String, String> dogPedigreeGroup;

  // Other fields
  Map<String, String> diseaseResult;
  String pkAdminId;

  Data({
    required this.catDisease,
    required this.catCoat,
    required this.catHair,
    required this.catVariety,
    required this.catPedigreeGroup,
    required this.dogDisease,
    required this.dogCoat,
    required this.dogHair,
    required this.dogVariety,
    required this.dogPedigreeGroup,
    required this.diseaseResult,
    required this.pkAdminId,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      catDisease: Map<String, String>.from(json['cat_disease'] ?? {}),
      catCoat: Map<String, String>.from(json['cat_coat'] ?? {}),
      catHair: Map<String, String>.from(json['cat_hair'] ?? {}),
      catVariety: Map<String, String>.from(json['cat_variety'] ?? {}),
      catPedigreeGroup: Map<String, String>.from(json['cat_pedigree_grp'] ?? {}),
      dogDisease: Map<String, String>.from(json['dog_disease'] ?? {}),
      dogCoat: Map<String, String>.from(json['dog_coat'] ?? {}),
      dogHair: Map<String, String>.from(json['dog_hair'] ?? {}),
      dogVariety: Map<String, String>.from(json['dog_variety'] ?? {}),
      dogPedigreeGroup: Map<String, String>.from(json['dog_pedigree_grp'] ?? {}),
      diseaseResult: Map<String, String>.from(json['disease_result'] ?? {}),
      pkAdminId: json['pk_admin_id'] ?? '',
    );
  }
}
