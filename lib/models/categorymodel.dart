// To parse this JSON data, do
//
//     final productCategoryIdModel = productCategoryIdModelFromJson(jsonString);

import 'dart:convert';

ProductCategoryIdModel productCategoryIdModelFromJson(String str) => ProductCategoryIdModel.fromJson(json.decode(str));

String productCategoryIdModelToJson(ProductCategoryIdModel data) => json.encode(data.toJson());

class ProductCategoryIdModel {
  ProductCategoryIdModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory ProductCategoryIdModel.fromJson(Map<String, dynamic> json) => ProductCategoryIdModel(
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
    this.productId,
    this.productName,
    this.productProfile,
    this.productPrice,
    this.productOffPrice,
    this.productRating,
    this.productDescription,
    this.rewardPoint,
    this.images,
  });

  int productId;
  String productName;
  String productProfile;
  String productPrice;
  int productOffPrice;
  String productRating;
  String productDescription;
  String rewardPoint;
  List<String> images;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    productId: json["productId"],
    productName: json["productName"],
    productProfile: json["productProfile"],
    productPrice: json["productPrice"],
    productOffPrice: json["productOffPrice"],
    productRating: json["productRating"],
    productDescription: json["productDescription"],
    rewardPoint: json["rewardPoint"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "productProfile": productProfile,
    "productPrice": productPrice,
    "productOffPrice": productOffPrice,
    "productRating": productRating,
    "productDescription": productDescription,
    "rewardPoint": rewardPoint,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}
