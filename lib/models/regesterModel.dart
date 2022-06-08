// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.userId,
    this.firstName,
  });

  int userId;
  String firstName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["UserId"],
    firstName: json["FirstName"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "FirstName": firstName,
  };
}
