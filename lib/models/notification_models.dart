import 'dart:convert';

// Function to parse the JSON string into NotificationClass
NotificationModel notificationClassFromJson(String str) => NotificationModel.fromJson(json.decode(str));

// Function to convert NotificationClass back to JSON string
String notificationClassToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String statusCode;
  NotificationBody body;

  NotificationModel({
    required this.statusCode,
    required this.body,
  });

  // Factory constructor to create NotificationClass from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    statusCode: json["statusCode"],
    body: NotificationBody.fromJson(json["body"]),
  );

  // Convert NotificationClass instance to JSON
  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "body": body.toJson(),
  };
}

class NotificationBody {
  String endpointArn;

  NotificationBody({
    required this.endpointArn,
  });

  // Factory constructor to create NotificationBody from JSON
  factory NotificationBody.fromJson(Map<String, dynamic> json) => NotificationBody(
    endpointArn: json["endpoint_arn"],
  );

  // Convert NotificationBody instance to JSON
  Map<String, dynamic> toJson() => {
    "endpoint_arn": endpointArn,
  };
}
