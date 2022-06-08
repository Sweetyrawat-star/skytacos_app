// To parse this JSON data, do
//
//     final blogModel = blogModelFromJson(jsonString);

import 'dart:convert';

BlogModel blogModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String blogModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {
  BlogModel({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
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
    this.blogId,
    this.blogTitle,
    this.blogContent,
    this.blogImage,
    this.blogVideo,
  });

  int blogId;
  String blogTitle;
  String blogContent;
  String blogImage;
  String blogVideo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    blogId: json["blogId"],
    blogTitle: json["blogTitle"],
    blogContent: json["blogContent"],
    blogImage: json["blogImage"],
    blogVideo: json["blogVideo"],
  );

  Map<String, dynamic> toJson() => {
    "blogId": blogId,
    "blogTitle": blogTitle,
    "blogContent": blogContent,
    "blogImage": blogImage,
    "blogVideo": blogVideo,
  };
}
