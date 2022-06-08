// To parse this JSON data, do
//
//     final gerCategoryModel = gerCategoryModelFromJson(jsonString);

import 'dart:convert';

GerCategoryModel gerCategoryModelFromJson(String str) => GerCategoryModel.fromJson(json.decode(str));

String gerCategoryModelToJson(GerCategoryModel data) => json.encode(data.toJson());

class GerCategoryModel {
  GerCategoryModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory GerCategoryModel.fromJson(Map<String, dynamic> json) => GerCategoryModel(
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
    this.categoryId,
    this.categoryName,
    this.catImage,
  });

  int categoryId;
  String categoryName;
  String catImage;

  factory Datum.fromJson(Map<String, dynamic> json) =>     Datum(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    catImage: json["catImage"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "catImage": catImage,
  };
}