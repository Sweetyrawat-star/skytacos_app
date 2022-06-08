import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/models/aboutUsModel.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String token;
  bool isLoading = false;
  String name, userId, phoneNumber, email,image;
  int id;
  Future<AboutUsModel> getRankData() async {
    final url = "http://skytacos.ouctus-platform.com/skystacos/v1/about";
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print('Token : ${token}');
    print(response);
    if (response.statusCode == 200) {
      final jsonPropertyVault = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
        userId = jsonPropertyVault["data"]["aboutUsId"].toString();
        print("id $userId");
        name = jsonPropertyVault["data"]["aboutUsTitle"].toString();
        print("name $name");
        email = jsonPropertyVault["data"]["aboutUsContent"].toString();
        print(" email $email");
        phoneNumber = jsonPropertyVault["data"]["aboutImage"].toString();
        print(" number$phoneNumber");
        image = jsonPropertyVault["data"]["imagePath"].toString();

      return AboutUsModel.fromJson(jsonPropertyVault);
    } else {
      throw Exception();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffEFEFEF),
        appBar: AppBar(
          backgroundColor: Color(0xff61CE70),
          title: Text(
            "About us",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading:  Padding(
            padding: const EdgeInsets.only(top:15.0,left: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/images/slider-icon.png",height: 33,))),
          ),
        ),
        body: FutureBuilder(
          future: getRankData(),
          builder: (BuildContext context, AsyncSnapshot<AboutUsModel> snapshot){
            if(snapshot.hasData){
              return
                ListView(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            ApiHandler.url+snapshot.data.data.aboutImage
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Savor",
                            style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontFamily: "Pacifico"),
                          ),
                          Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                              ),
                              child: Text(
                                snapshot.data.data.aboutUsTitle,
                               // "SKY'S GOURMET TACOS",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        snapshot.data.data.aboutUsContent,
                        style: TextStyle(
                            color: ColorUtils.lightBlue, letterSpacing: 0.7),
                      ),
                    ),
                  ],
                );

            }
            else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),);
  }
}
