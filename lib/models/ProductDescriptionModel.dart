class ProductDescriptionModel {
  String status;
  String message;
  Data data;

  ProductDescriptionModel({this.status, this.message, this.data});

  ProductDescriptionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int productId;
  String categoryName;
  String productName;
  String productProfile;
  String productPrice;
  String productOffPrice;
  String productDescription;
  var productRating;
  String productReview;
  String rewardPoint;
  String requiredChooseOption;
  List<RequiredChooseOptionFields> requiredChooseOptionFields;
  List<String> images;
  List<AddOn> addOn;

  Data(
      {this.productId,
      this.categoryName,
      this.productName,
      this.productProfile,
      this.productPrice,
      this.productOffPrice,
      this.productDescription,
      this.productRating,
      this.productReview,
      this.rewardPoint,
      this.requiredChooseOption,
      this.requiredChooseOptionFields,
      this.images,
      this.addOn});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    categoryName= json['categoryName'];
    productName = json['productName'];
    productProfile = json['productProfile'];
    productPrice = json['productPrice'];
    productOffPrice = json['productOffPrice'];
    productDescription = json['productDescription'];
    productRating = json['productRating'];
    productReview = json['productReview'];
    rewardPoint = json['rewardPoint'];
    requiredChooseOption = json['required_choose_option'];
    if (json['required_choose_option_fields'] != null) {
      requiredChooseOptionFields = new List<RequiredChooseOptionFields>();
      json['required_choose_option_fields'].forEach((v) {
        requiredChooseOptionFields
            .add(new RequiredChooseOptionFields.fromJson(v));
      });
    }
    images = json['images'].cast<String>();
    if (json['add_on'] != null) {
      addOn = new List<AddOn>();
      json['add_on'].forEach((v) {
        addOn.add(new AddOn.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['categoryName']= this.categoryName;
    data['productName'] = this.productName;
    data['productProfile'] = this.productProfile;
    data['productPrice'] = this.productPrice;
    data['productOffPrice'] = this.productOffPrice;
    data['productDescription'] = this.productDescription;
    data['productRating'] = this.productRating;
    data['productReview'] = this.productReview;
    data['rewardPoint'] = this.rewardPoint;
    data['required_choose_option'] = this.requiredChooseOption;
    if (this.requiredChooseOptionFields != null) {
      data['required_choose_option_fields'] =
          this.requiredChooseOptionFields.map((v) => v.toJson()).toList();
    }
    data['images'] = this.images;
    if (this.addOn != null) {
      data['add_on'] = this.addOn.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequiredChooseOptionFields {
  int requiredProductId;
  String requiredProduct;
  var price;
 
  RequiredChooseOptionFields(
      {this.requiredProductId, this.requiredProduct, this.price});

  RequiredChooseOptionFields.fromJson(Map<String, dynamic> json) {
    requiredProductId = json['required_product_id'];
    requiredProduct = json['required_product'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['required_product_id'] = this.requiredProductId;
    data['required_product'] = this.requiredProduct;
    data['price'] = this.price;
    return data;
  }
}

class AddOn {
  int addOnId;
  String addOnName;
  var addOnPrice;

  AddOn({this.addOnId, this.addOnName, this.addOnPrice});

  AddOn.fromJson(Map<String, dynamic> json) {
    addOnId = json['add_on_id'];
    addOnName = json['add_on_name'];
    addOnPrice = json['add_on_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add_on_id'] = this.addOnId;
    data['add_on_name'] = this.addOnName;
    data['add_on_price'] = this.addOnPrice;
    return data;
  }
}
