class GetProfile {
  String status;
  String message;
  Data data;

  GetProfile({this.status, this.message, this.data});

  GetProfile.fromJson(Map<String, dynamic> json) {
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
  int userId;
  String firstName;
  String emailAddress;
  String phoneNumber;
  String profileImage;

  Data(
      {this.userId,
      this.firstName,
      this.emailAddress,
      this.phoneNumber,
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    firstName = json['FirstName'];
    emailAddress = json['emailAddress'];
    phoneNumber = json['phoneNumber'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['FirstName'] = this.firstName;
    data['emailAddress'] = this.emailAddress;
    data['phoneNumber'] = this.phoneNumber;
    data['profileImage'] = this.profileImage;
    return data;
  }
}