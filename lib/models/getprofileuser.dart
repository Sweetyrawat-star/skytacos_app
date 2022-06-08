// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.userId,
    this.firstName,
    this.emailAddress,
    this.phoneNumber,
    this.profileImage,
  });

  int userId;
  String firstName;
  String emailAddress;
  String phoneNumber;
  String profileImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["UserId"],
    firstName: json["FirstName"],
    emailAddress: json["emailAddress"],
    phoneNumber: json["phoneNumber"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "FirstName": firstName,
    "emailAddress": emailAddress,
    "phoneNumber": phoneNumber,
    "profileImage": profileImage,
  };
}