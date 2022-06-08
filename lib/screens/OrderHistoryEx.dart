import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/Utils/color_utils.dart';

import 'package:skystacos_app/models/MyOrderModel.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';
import 'package:skystacos_app/screens/OrderSummery.dart';
import 'package:http/http.dart' as http;

class MyOrderHistoryEx extends StatefulWidget {
  @override
  _MyOrderHistoryExState createState() => _MyOrderHistoryExState();
}

class _MyOrderHistoryExState extends State<MyOrderHistoryEx> {
  ApiHandler handler = ApiHandler();

  @override
  void initState() {
    handler.getMyOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "My Order",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10),
          child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Image.asset(
                    "assets/images/slider-icon.png",
                    height: 33,
                  ))),
        ),
      ),
      backgroundColor: Color(0xffF3F3F3),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          buildProductList(),
        ],
      ),
    );
  }

  buildProductList() {
    return FutureBuilder<MyOrderModel>(
      future: handler.getMyOrder(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data.data.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.data.length,
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrderSummery(
                                          orderId: snapshot
                                              .data.data[index].orderId
                                              .toInt()
                                              .toString(),
                                        )));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Color(0xffeae8e6),
                              ),
                              child: Column(children: [
                                Container(
                                  height: 30,
                                  width: 360,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Ordered Id: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                  snapshot
                                                      .data.data[index].orderId
                                                      .toInt()
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshot
                                            .data.data[index].product.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            child: Row(
                                              children: [
                                                Text("Items: ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    snapshot
                                                        .data
                                                        .data[index]
                                                        .product[index]
                                                        .productName
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w300)),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Ordered On: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  snapshot.data.data[index]
                                                      .orderDate
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                              Text(" at ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                              Text(
                                                  snapshot.data.data[index]
                                                      .orderTime
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Total Amount: ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                              snapshot
                                                  .data.data[index].totalPrice
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 90,
                                              child: RaisedButton(
                                                textColor: Colors.white,
                                                color: Color(0xff61CE70),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  "ReOrder",
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 30,
                                              width: 90,
                                              child: RaisedButton(
                                                textColor: Colors.black,
                                                color: Color(0xffD1D1D1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  "Feedback",
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ])),
                        ));
                  },
                )
              : Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/order.png",
                        height: 100,
                        color: ColorUtils.greyLightColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("You haven't placed any orders yet. ",
                          style: TextStyle(
                              color: ColorUtils.greyLightColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
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
