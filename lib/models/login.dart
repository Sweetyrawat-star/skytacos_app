// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  LoginData data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    status: json["status"],
    message: json["message"],
    data: LoginData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class LoginData {
  LoginData({
    this.data,
    this.token,
  });

  DataData data;
  String token;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    data: DataData.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "token": token,
  };
}

class DataData {
  DataData({
    this.userId,
    this.firstName,
  });

  int userId;
  String firstName;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
    userId: json["UserId"],
    firstName: json["firstName"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "firstName": firstName,
  };
}
