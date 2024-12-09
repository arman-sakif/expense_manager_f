import 'dart:convert';

class CompanyDetailsModel {
  String statusCode;
  Body body;

  CompanyDetailsModel({
    required this.statusCode,
    required this.body,
  });

  // Parsing from raw JSON string
  factory CompanyDetailsModel.fromRawJson(String str) =>
      CompanyDetailsModel.fromJson(json.decode(str));

  // Convert to raw JSON string
  String toRawJson() => json.encode(toJson());

  // From JSON to CompanyDetailsModel
  factory CompanyDetailsModel.fromJson(Map<String, dynamic> json) {
    return CompanyDetailsModel(
      statusCode: json["statusCode"],
      body: Body.fromJson(json["body"]),
    );
  }

  // Convert from CompanyDetailsModel to JSON
  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "body": body.toJson(),
  };
}

class Body {
  final String representativeName;
  final String status;
  final String pkCompanyId;
  final String? email;
  final String name;
  final String? faxNumber;
  final String? nameFurigana;
  final String? representativeNameFurigana;
  final String? affiliatedPark;
  final String? dateExpiry;
  final String deleteFlag;
  final String? locationPrefecture;
  final String? locationCity;
  final String? corporateClassification;
  final String? breederRepresentation;
  final String? productionPrefecture;
  final String? createdAt;
  final String? updatedAt;
  final String skUserId;
  final String? postCode;
  final String? telephoneNumber;
  final String? number;
  final String? productionArea;
  final String? locationChome;
  final String? mobileNumber;
  final String? militaryName;

  Body({
    required this.representativeName,
    required this.status,
    required this.pkCompanyId,
    this.email,
    required this.name,
    this.faxNumber,
    this.nameFurigana,
    this.representativeNameFurigana,
    this.affiliatedPark,
    this.dateExpiry,
    required this.deleteFlag,
    this.locationPrefecture,
    this.locationCity,
    this.corporateClassification,
    this.breederRepresentation,
    this.productionPrefecture,
    this.createdAt,
    this.updatedAt,
    required this.skUserId,
    this.postCode,
    this.telephoneNumber,
    this.number,
    this.productionArea,
    this.locationChome,
    this.mobileNumber,
    this.militaryName,
  });

  // Parsing from raw JSON string
  factory Body.fromRawJson(String str) => Body.fromJson(json.decode(str));

  // Convert to raw JSON string
  String toRawJson() => json.encode(toJson());

  // From JSON to Body
  factory Body.fromJson(Map<String, dynamic> json) => Body(
    representativeName: json["representative_name"] ?? '',
    status: json["status"] ?? '',
    pkCompanyId: json["pk_company_id"] ?? '',
    email: json["email"],
    name: json["name"] ?? '',
    faxNumber: json["fax_number"],
    nameFurigana: json["name_furigana"],
    representativeNameFurigana: json["representative_name_furigana"],
    affiliatedPark: json["affiliated_park"],
    dateExpiry: json["date_expiry"],
    deleteFlag: json["delete_flag"] ?? '',
    locationPrefecture: json["location_prefecture"],
    locationCity: json["location_city"],
    corporateClassification: json["corporate_classification"],
    breederRepresentation: json["breeder_representation"],
    productionPrefecture: json["production_prefecture"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    skUserId: json["sk_user_id"] ?? '',
    postCode: json["post_code"],
    telephoneNumber: json["telephone_number"],
    number: json["number"],
    productionArea: json["production_area"],
    locationChome: json["location_chome"],
    mobileNumber: json["mobile_number"],
    militaryName: json["military_name"],
  );

  // Convert from Body to JSON
  Map<String, dynamic> toJson() => {
    "representative_name": representativeName,
    "status": status,
    "pk_company_id": pkCompanyId,
    "email": email,
    "name": name,
    "fax_number": faxNumber,
    "name_furigana": nameFurigana,
    "representative_name_furigana": representativeNameFurigana,
    "affiliated_park": affiliatedPark,
    "date_expiry": dateExpiry,
    "delete_flag": deleteFlag,
    "location_prefecture": locationPrefecture,
    "location_city": locationCity,
    "corporate_classification": corporateClassification,
    "breeder_representation": breederRepresentation,
    "production_prefecture": productionPrefecture,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "sk_user_id": skUserId,
    "post_code": postCode,
    "telephone_number": telephoneNumber,
    "number": number,
    "production_area": productionArea,
    "location_chome": locationChome,
    "mobile_number": mobileNumber,
    "military_name": militaryName,
  };
}
