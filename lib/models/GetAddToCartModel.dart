// // To parse this JSON data, do
// //
// //     final getAddToCartModel = getAddToCartModelFromJson(jsonString);
//
// import 'dart:convert';
//
// GetAddToCartModel getAddToCartModelFromJson(String str) => GetAddToCartModel.fromJson(json.decode(str));
//
// String getAddToCartModelToJson(GetAddToCartModel data) => json.encode(data.toJson());
//
// class GetAddToCartModel {
//   GetAddToCartModel({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   String status;
//   String message;
//   List<Datum> data;
//
//   factory GetAddToCartModel.fromJson(Map<String, dynamic> json) => GetAddToCartModel(
//     status: json["status"],
//     message: json["message"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     this.cartId,
//     this.catName,
//     this.productId,
//     this.productProfile,
//     this.productName,
//     this.productPrice,
//     this.productQuantity,
//     this.rewardPoints,
//     this.price,
//     this.totalPrice,
//     this.totalRewardPoints,
//   });
//
//   int cartId;
//   String catName;
//   int productId;
//   String productProfile;
//   String productName;
//   String productPrice;
//   String productQuantity;
//   String rewardPoints;
//   double price;
//   double totalPrice;
//   int totalRewardPoints;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     cartId: json["cartId"],
//     catName: json["catName"],
//     productId: json["productId"],
//     productProfile: json["productProfile"],
//     productName: json["productName"],
//     productPrice: json["productPrice"],
//     productQuantity: json["productQuantity"],
//     rewardPoints: json["rewardPoints"],
//     price: json["price"],
//     totalPrice: json["TotalPrice"],
//     totalRewardPoints: json["TotalRewardPoints"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cartId": cartId,
//     "catName": catName,
//     "productId": productId,
//     "productProfile": productProfile,
//     "productName": productName,
//     "productPrice": productPrice,
//     "productQuantity": productQuantity,
//     "rewardPoints": rewardPoints,
//     "price": price,
//     "TotalPrice": totalPrice,
//     "TotalRewardPoints": totalRewardPoints,
//   };
// }
class GetAddToCartModel {
  String status;
  String message;
  List<Data> data;

  GetAddToCartModel({this.status, this.message, this.data});

  GetAddToCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int cartId;
  String catName;
  int productId;
  String productProfile;
  String productName;
  String productPrice;
  String productQuantity;
  String rewardPoints;
  String price;
  String totalPrice;
  int totalRewardPoints;

  Data(
      {this.cartId,
        this.catName,
        this.productId,
        this.productProfile,
        this.productName,
        this.productPrice,
        this.productQuantity,
        this.rewardPoints,
        this.price,
        this.totalPrice,
        this.totalRewardPoints});

  Data.fromJson(Map<String, dynamic> json) {
    cartId = json['cartId'];
    catName = json['catName'];
    productId = json['productId'];
    productProfile = json['productProfile'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productQuantity = json['productQuantity'];
    rewardPoints = json['rewardPoints'];
    price = json['price'];
    totalPrice = json['TotalPrice'];
    totalRewardPoints = json['TotalRewardPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cartId'] = this.cartId;
    data['catName'] = this.catName;
    data['productId'] = this.productId;
    data['productProfile'] = this.productProfile;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['productQuantity'] = this.productQuantity;
    data['rewardPoints'] = this.rewardPoints;
    data['price'] = this.price;
    data['TotalPrice'] = this.totalPrice;
    data['TotalRewardPoints'] = this.totalRewardPoints;
    return data;
  }
}