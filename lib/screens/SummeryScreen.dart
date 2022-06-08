import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/models/GetAddToCartModel.dart';

class SummeryScreen extends StatefulWidget {
  @override
  _SummeryScreenState createState() => _SummeryScreenState();
}

class _SummeryScreenState extends State<SummeryScreen> {

  double count = 1;
  int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  String reward, totalReward;
   Future<GetAddToCartModel> getCartProduct() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    print("token" + "$token");
    final url =
        "http://skytacos.ouctus-platform.com/skystacos/v1/getcart";
    final response = await http.get(
        url, headers: {
      // HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    }
    );
    print(response);
    if (response.statusCode == 200) {
      final jsonPropertyVault = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return GetAddToCartModel.fromJson(jsonPropertyVault);
    } else {
      throw Exception();
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff61CE70),
          title: Text(
            "SummeryPage",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: ColorUtils.appColor,
          ),
          child: Center(child: Text("Proceed To Pay",style: TextStyle(color: Colors.white),)),
        ),
        body: ListView(children: [
      buildProductList(),

    ]));
  }

  buildProductList() {
    return FutureBuilder(
      future: getCartProduct(),
      builder:
          (BuildContext context, AsyncSnapshot<GetAddToCartModel> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.white),
                      bottom: BorderSide(color: Colors.white)),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Color(0xff61ca72),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 17,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                              "2222 LOYALTY REWARD POINTS(\$${snapshot.data.data[0].totalRewardPoints})",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(snapshot.data.data.length.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                          Text("ITEM",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.data.length,
                padding: EdgeInsets.all(10.0),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color(0xffeae8e6),
                          ),
                          child: Row(children: [
                            Container(
                              height: 107,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      ApiHandler.url +
                                          snapshot
                                              .data.data[index].productProfile,
                                    ),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: Text(snapshot.data.data[index].productName,
                                        maxLines: 1,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width: 210,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 180,
                                          child: Text(snapshot.data.data[index].catName,
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),

                                  Container(
                                    width: 210,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                "\$${snapshot.data.data[index].productPrice}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 25,
                                        
                                              width: 60,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffC6C6C6)),
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "-",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 18,
                                                        color:
                                                            Color(0xff61CE70)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    snapshot.data.data[index]
                                                        .productQuantity,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff61CE70)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "+",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff61CE70)),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: Image.asset(
                                            "assets/images/delete-icon.png",
                                            height: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])));
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0,right: 10.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(

                        border: Border.all(color: Colors.grey[300]),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex:0,
                                child: Icon(Icons.attachment,color: ColorUtils.appColor,),
                              ),
                              Expanded(
                                flex:3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('10% Instant off* with ICICI Bank debit & Credit cards'),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex:0,
                                child: Icon(Icons.attachment,color: ColorUtils.appColor),
                              ),
                              Expanded(
                                flex:3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('5% Instant off* with Axis Bank debit & Credit cards'),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text('View all offers',
                              style: TextStyle(color: ColorUtils.appColor,fontWeight: FontWeight.bold),)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 1,
                                        groupValue: selectedRadioTile,
                                        title: Text("Home Delivery"),
                                        onChanged: (val) {
                                          print("Radio Tile pressed $val");
                                          setSelectedRadioTile(val);
                                        },
                                        activeColor: ColorUtils.appColor,
                                      ),
                                    ),

                                  ],
                                ),
                                selectedRadioTile == 1
                                    ? Padding(
                                  padding: EdgeInsets.only(left: 70.0, bottom: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                              onTap: () {},
                                              child: Text("Fill Address",
                                                  style: TextStyle(
                                                      color: Colors.blueAccent)))),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey[300]),
                                              borderRadius: BorderRadius.circular(6.0)),
                                          child: TextField(
                                            
                                            decoration: InputDecoration(
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.transparent),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.transparent),
                                              ),
                                            ),
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(
                                        value: 6,
                                        groupValue: selectedRadioTile,
                                        title: Text("Other Address"),
                                        onChanged: (val) {
                                          print("Radio Tile pressed $val");
                                          setSelectedRadioTile(val);
                                        },
                                        activeColor: ColorUtils.appColor,
                                      ),
                                    )
                                  ],
                                ),
                                selectedRadioTile == 6
                                    ? Padding(
                                  padding: EdgeInsets.only(left: 70.0, bottom: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: GestureDetector(
                                              onTap: () {},
                                              child: Text("Fill Address",
                                                  style: TextStyle(
                                                      color: Colors.blueAccent)))),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 40.0,
                                          width: 300  ,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey[300]),
                                              borderRadius: BorderRadius.circular(6.0)),
                                          child: TextField(
                                          
                                            decoration: InputDecoration(

                                              enabledBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.transparent),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide:
                                                BorderSide(color: Colors.transparent),
                                              ),
                                            ),
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          )
                        ])),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Price Details',style: TextStyle(color: ColorUtils.appColor,),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex:5,
                                            child: Text(snapshot.data.data[0].productName)),
                                        Expanded(
                                            flex:1,
                                            child: Text( "\$${snapshot.data.data[0].productPrice}",
                                              style: TextStyle(color:Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)
                                              ,)
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            flex:5,
                                            child: Text(snapshot.data.data[0].productName)),
                                        Expanded(
                                            flex:1,
                                            child: Text( "\$${snapshot.data.data[0].productPrice}",
                                              style: TextStyle(color:Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400)
                                              ,)
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left:8.0,top: 8.0,bottom: 8.0,right: 8),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        flex:5,
                                        child: Text('Grand Total')),
                                    Expanded(
                                        flex:1,
                                        child: Text( "\$${snapshot.data.data[0].totalPrice}",
                                          style: TextStyle(color: ColorUtils.redAppColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)
                                          ,)
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30.0,
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
