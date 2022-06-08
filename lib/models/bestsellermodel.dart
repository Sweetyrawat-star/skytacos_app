class BestSellerModel {
  String status;
  String message;
  List<Data> data;

  BestSellerModel({this.status, this.message, this.data});

  BestSellerModel.fromJson(Map<String, dynamic> json) {
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
  int productId;
  String productName;
  String productProfile;
  String productPrice;
  int productOffPrice;
  Null productRating;
  String productDescription;
  String rewardPoint;
  List<String> images;

  Data(
      {this.productId,
        this.productName,
        this.productProfile,
        this.productPrice,
        this.productOffPrice,
        this.productRating,
        this.productDescription,
        this.rewardPoint,
        this.images});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productProfile = json['productProfile'];
    productPrice = json['productPrice'];
    productOffPrice = json['productOffPrice'];
    productRating = json['productRating'];
    productDescription = json['productDescription'];
    rewardPoint = json['rewardPoint'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productProfile'] = this.productProfile;
    data['productPrice'] = this.productPrice;
    data['productOffPrice'] = this.productOffPrice;
    data['productRating'] = this.productRating;
    data['productDescription'] = this.productDescription;
    data['rewardPoint'] = this.rewardPoint;
    data['images'] = this.images;
    return data;
  }
}
