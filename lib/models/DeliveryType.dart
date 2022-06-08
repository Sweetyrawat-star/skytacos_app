// To parse this JSON data, do
//
//     final deliveryTypeModel = deliveryTypeModelFromJson(jsonString);

import 'dart:convert';

DeliveryTypeModel deliveryTypeModelFromJson(String str) => DeliveryTypeModel.fromJson(json.decode(str));

String deliveryTypeModelToJson(DeliveryTypeModel data) => json.encode(data.toJson());

class DeliveryTypeModel {
  DeliveryTypeModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory DeliveryTypeModel.fromJson(Map<String, dynamic> json) => DeliveryTypeModel(
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
    this.deliveryId,
    this.type,
  });

  int deliveryId;
  String type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    deliveryId: json["deliveryId"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "deliveryId": deliveryId,
    "type": type,
  };
}
