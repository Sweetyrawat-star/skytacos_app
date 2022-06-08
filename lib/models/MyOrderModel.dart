class MyOrderModel {
  String status;
  String message;
  List<Data> data;

  MyOrderModel({this.status, this.message, this.data});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
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
  int orderId;
  String paymentMode;
  String orderStatus;
  String deliveryType;
  String totalPrice;
  String rewardPoints;
  String orderDate;
  String orderTime;
  String street;
  String address1;
  String address2;
  String state;
  String city;
  String zipCode;
  List<Product> product;

  Data(
      {this.orderId,
      this.paymentMode,
      this.orderStatus,
      this.deliveryType,
      this.totalPrice,
      this.rewardPoints,
      this.orderDate,
      this.orderTime,
      this.street,
      this.address1,
      this.address2,
      this.state,
      this.city,
      this.zipCode,
      this.product});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    paymentMode = json['paymentMode'];
    orderStatus = json['orderStatus'];
    deliveryType = json['deliveryType'];
    totalPrice = json['totalPrice'];
    rewardPoints = json['rewardPoints'];
    orderDate = json['orderDate'];
    orderTime = json['orderTime'];
    street = json['street'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zipCode'];
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['paymentMode'] = this.paymentMode;
    data['orderStatus'] = this.orderStatus;
    data['deliveryType'] = this.deliveryType;
    data['totalPrice'] = this.totalPrice;
    data['rewardPoints'] = this.rewardPoints;
    data['orderDate'] = this.orderDate;
    data['orderTime'] = this.orderTime;
    data['street'] = this.street;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zipCode'] = this.zipCode;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int orderId;
  int productId;
  String productName;
  String productPrice;
  String productQuantity;

  Product(
      {this.orderId,
      this.productId,
      this.productName,
      this.productPrice,
      this.productQuantity});

  Product.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    productId = json['productId'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productQuantity = json['productQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['productQuantity'] = this.productQuantity;
    return data;
  }
}