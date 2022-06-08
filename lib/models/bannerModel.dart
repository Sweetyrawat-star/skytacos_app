// To parse this JSON data, do
//
//     final bannerGetImageModel = bannerGetImageModelFromJson(jsonString);

import 'dart:convert';

BannerGetImageModel bannerGetImageModelFromJson(String str) => BannerGetImageModel.fromJson(json.decode(str));

String bannerGetImageModelToJson(BannerGetImageModel data) => json.encode(data.toJson());

class BannerGetImageModel {
  BannerGetImageModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory BannerGetImageModel.fromJson(Map<String, dynamic> json) => BannerGetImageModel(
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
    this.bannerId,
    this.bannerHeading,
    this.bannerImage,
    this.bannerText,
  });

  int bannerId;
  String bannerHeading;
  String bannerImage;
  String bannerText;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bannerId: json["bannerId"],
    bannerHeading: json["bannerHeading"],
    bannerImage: json["bannerImage"],
    bannerText: json["bannerText"],
  );

  Map<String, dynamic> toJson() => {
    "bannerId": bannerId,
    "bannerHeading": bannerHeading,
    "bannerImage": bannerImage,
    "bannerText": bannerText,
  };
}
