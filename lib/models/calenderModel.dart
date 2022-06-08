// To parse this JSON data, do
//
//     final calenderModel = calenderModelFromJson(jsonString);

import 'dart:convert';

CalenderModel calenderModelFromJson(String str) => CalenderModel.fromJson(json.decode(str));

String calenderModelToJson(CalenderModel data) => json.encode(data.toJson());

class CalenderModel {
  CalenderModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory CalenderModel.fromJson(Map<String, dynamic> json) => CalenderModel(
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
    this.timingId,
    this.date,
    this.time,
  });

  int timingId;
  String date;
  String time;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    timingId: json["timingId"],
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "timingId": timingId,
    "date": date,
    "time": time,
  };
}