// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);

import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) => EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) => json.encode(data.toJson());

class EditProfileModel {
  EditProfileModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
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
    this.user,
    this.address,
  });

  List<User> user;
  List<Address> address;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
    address: List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
    "address": List<dynamic>.from(address.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.addressId,
    this.street,
    this.address1,
    this.address2,
    this.state,
    this.city,
    this.zipCode,
    this.customerId,
    this.createdAt,
    this.updatedAt,
  });

  int addressId;
  String street;
  String address1;
  String address2;
  String state;
  String city;
  String zipCode;
  int customerId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressId: json["address_id"],
    street: json["street"],
    address1: json["address_1"],
    address2: json["address_2"],
    state: json["state"],
    city: json["city"],
    zipCode: json["zip_code"],
    customerId: json["customer_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "address_id": addressId,
    "street": street,
    "address_1": address1,
    "address_2": address2,
    "state": state,
    "city": city,
    "zip_code": zipCode,
    "customer_id": customerId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class User {
  User({
    this.userId,
    this.firstName,
    this.phoneNumber,
  });

  int userId;
  String firstName;
  String phoneNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["UserId"],
    firstName: json["FirstName"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "FirstName": firstName,
    "phoneNumber": phoneNumber,
  };
}
