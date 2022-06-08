// To parse this JSON data, do
//
//     final profileImagePicker = profileImagePickerFromJson(jsonString);

import 'dart:convert';

ProfileImagePicker profileImagePickerFromJson(String str) => ProfileImagePicker.fromJson(json.decode(str));

String profileImagePickerToJson(ProfileImagePicker data) => json.encode(data.toJson());

class ProfileImagePicker {
  ProfileImagePicker({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory ProfileImagePicker.fromJson(Map<String, dynamic> json) => ProfileImagePicker(
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
    this.profileImage,
  });

  int userId;
  String profileImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["UserId"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "profileImage": profileImage,
  };
}
