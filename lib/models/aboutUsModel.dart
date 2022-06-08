// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  AboutUsModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
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
    this.aboutUsId,
    this.aboutUsTitle,
    this.aboutUsContent,
    this.aboutImage,
  });

  int aboutUsId;
  String aboutUsTitle;
  String aboutUsContent;
  String aboutImage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    aboutUsId: json["aboutUsId"],
    aboutUsTitle: json["aboutUsTitle"],
    aboutUsContent: json["aboutUsContent"],
    aboutImage: json["aboutImage"],
  );

  Map<String, dynamic> toJson() => {
    "aboutUsId": aboutUsId,
    "aboutUsTitle": aboutUsTitle,
    "aboutUsContent": aboutUsContent,
    "aboutImage": aboutImage,
  };
}
