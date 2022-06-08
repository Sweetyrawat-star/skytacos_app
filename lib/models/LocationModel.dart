class LocationDropdownModel {
  int status;
  String message;
  List<Data> data;

  LocationDropdownModel({this.status, this.message, this.data});

  LocationDropdownModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  String address;
  String restName;
  String longitude;
  String latitude;
  double distance;

  Data(
      {this.id,
        this.address,
        this.restName,
        this.longitude,
        this.latitude,
        this.distance});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    restName = json['rest_name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['rest_name'] = this.restName;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['distance'] = this.distance;
    return data;
  }
}