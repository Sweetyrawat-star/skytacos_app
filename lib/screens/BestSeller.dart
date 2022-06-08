import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/models/bestsellermodel.dart';
import 'package:skystacos_app/screens/ProductDetailScreen.dart';

class BestSeller extends StatelessWidget {
 final String id;
 BestSeller({this.id});
  static var value;
  Future<BestSellerModel> getBestSeller() async {
    // Future.delayed(const Duration(seconds: 2), () {
    //
    //
    //   // setState(() {
    //   //   // Here you can write your code for open new view
    //   // });
    //
    // });
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString("token");
      var locationId = sharedPreferences.getString("id");
      print("token" + "$token");
      final url =
      // "http://skytacos.ouctus-platform.com/skystacos/v1/productbestseller";
          "http://skytacos.ouctus-platform.com/skystacos/v1/productbestseller?locationId=$id";
      final response = await http.get(
          url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      }
      );
      print(response);
      if (response.statusCode == 200) {
        BestSellerModel  model= BestSellerModel .fromJson(jsonDecode(response.body));
        final jsonPropertyVault = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        for(var i = 0; i< model.data.length; i++) {
          value =model.data[i].images;
          print(value);
        }
        return BestSellerModel.fromJson(jsonPropertyVault);
      } else {
        throw Exception();
      }
    }catch(e){
      print(e);
    }
    return BestSellerModel();
  }
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: getBestSeller(),
      builder: (BuildContext context, AsyncSnapshot<BestSellerModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.data.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 1.1
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  productId: snapshot
                                      .data.data[index].productId
                                      .toString(),
                                  description:
                                  snapshot.data.data[index].productName,
                                )));
                      },
                      child: new GridTile(
                          child: SafeArea(
                            // ignore: deprecated_member_use
                              child: Stack(
                                  overflow: Overflow.clip,
                                  children: <Widget>[
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Stack(children: <Widget>[
                                          Container(
                                            height: 107,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.0),
                                              image: DecorationImage(
                                                  image: snapshot.data.data[index]
                                                      .productProfile ==
                                                      null
                                                      ? AssetImage(
                                                    "assets/food1.jpg",
                                                  )
                                                      : NetworkImage(
                                                    ApiHandler.url +
                                                        snapshot.data.data[index]
                                                            .productProfile,
                                                  ),
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          Positioned(
                                              top: 5,
                                              left: 0.0,
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: ColorUtils.appColor,
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(30),
                                                      bottomRight: Radius.circular(30),
                                                    )),
                                                child: Center(
                                                    child: Text(
                                                      "BEST SELLER",
                                                      style: TextStyle(color: Colors.white,fontSize: 10),
                                                    )),
                                              ))
                                        ])),
                                    Positioned(
                                      top: 115,
                                      right: 10,
                                      left: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data.data[index].productName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]))));
                },
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
