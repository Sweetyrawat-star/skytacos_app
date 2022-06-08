import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/models/LocationModel.dart';
import 'package:skystacos_app/models/MyOrderModel.dart';
import 'package:skystacos_app/models/bestsellermodel.dart';
import 'package:skystacos_app/models/getCategory.dart';
import 'package:skystacos_app/models/getprofileuser.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';
import 'package:skystacos_app/sharedpreference/store.dart';


class ApiHandler{
  String name, userId, phoneNumber, email,imageUser;
  static var value;
  HomeScreen screen =HomeScreen();

  static String url = "http://skytacos.ouctus-platform.com/";
  static String imageUrl = "http://skytacos.ouctus-platform.com";
 static Future<List<dynamic>> getData() async {
    var response = await http.get("http://skytacos.ouctus-platform.com/skystacos/v1/user/53");
    if (response.statusCode == 200){
      // ignore: unused_local_variable
      var userDetails = json.decode(response.body);

      print(response.body);
      //return ProfileModel.fromJson(userDetails);
    }
    else {
      throw Exception('Failed to fetch data');
    }
    
  }

  Future<GerCategoryModel> getProductDetails() async {
   try{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token = sharedPreferences.getString("token");
     print("token" + "$token");
     final url = "http://skytacos.ouctus-platform.com/skystacos/v1/category";
     final response = await http.get(
       url,
     );
     print(response);
     if (response.statusCode == 200) {
       GerCategoryModel model=GerCategoryModel.fromJson(jsonDecode(response.body));
       var jsonPropertyVault = jsonDecode(response.body);
       print(response.statusCode);
       print(response.body);
       for(var i = 0; i< model.data.length; i++) {

         int value =model.data[i].categoryId;
         print(value);
         sharedPreferences.setInt("categoryId",value);
       }


       var token2 = sharedPreferences.getInt("categoryId");
       print(token2);
       return GerCategoryModel.fromJson(jsonPropertyVault);
     } else {
       throw Exception();
     }
   }catch(e){
     print(e);
   }
  }


  Future<MyOrderModel> getMyOrder() async {
   try{
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     var token = sharedPreferences.getString("token");
     print("token" + "$token");
     final url = "http://skytacos.ouctus-platform.com/skystacos/v1/orders";
     final response = await http.get(url, headers: {
      // HttpHeaders.contentTypeHeader: "application/json",
       HttpHeaders.authorizationHeader: "Bearer $token"
     });
     print(response);
     if (response.statusCode == 200) {
       final jsonPropertyVault = jsonDecode(response.body);
       print(response.statusCode);
       print(response.body);
       return MyOrderModel.fromJson(jsonPropertyVault);
     } else {
       throw Exception();
     }
   }catch(e){
     print(e);
   }
   return MyOrderModel();
  }
 
  Future<ProfileModel> getUser() async {
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      store1 = sharedPreferences.getString("token");
      print("token" + "$store1");
      final url = "http://skytacos.ouctus-platform.com/skystacos/v1/user";
      final response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $store1"
      });
      print(response);
      if (response.statusCode == 200) {
        final jsonPropertyVault = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        userId = jsonPropertyVault["data"]["UserId"].toString();
        name =  jsonPropertyVault["data"]["FirstName"].toString();
        email = jsonPropertyVault["data"]["emailAddress"].toString();
        imageUser = jsonPropertyVault["data"]["profileImage"].toString();
        phoneNumber =  jsonPropertyVault["data"]["phoneNumber"].toString();
        return ProfileModel.fromJson(jsonPropertyVault);
      } else {
        throw Exception();
      }
    }catch(e){
      print(e);
    }
  }
}