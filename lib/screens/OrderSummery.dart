import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:skystacos_app/models/MyOrderSummary.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/screens/OrderHistoryEx.dart';
class OrderSummery extends StatefulWidget {
  final orderId;
  OrderSummery({this.orderId});
  @override
  _OrderSummeryState createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery> {


  Future<MyOrderSummary > getOrderSummary() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    print("token" + "$token");
    final url =
        "http://skytacos.ouctus-platform.com/skystacos/v1/orders/${widget.orderId}";
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
      return MyOrderSummary.fromJson(jsonPropertyVault);
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
          "Order Summary  ",
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
                        MaterialPageRoute(builder: (context) => MyOrderHistoryEx()));
                  },
                  child: Image.asset(
                    "assets/images/slider-icon.png",
                    height: 33,
                  ))),
        ),
      ),
      backgroundColor: Color(0xffF3F3F3),
      body: FutureBuilder<MyOrderSummary>(
        future: getOrderSummary(),
        builder: (context,snapshot){
          if(snapshot.hasData){
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(children: [
                SizedBox(
              height: 10,
            ),
            Container(
              height: 30,
              width: 360,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey,),),
              ),
              child: Center(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Your Order: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.data.product.length,
              itemBuilder:(context, int index){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Text( snapshot.data.data.product[index].productName,
                   style: TextStyle(
               color: Colors.black,
               fontSize: 12,
               fontWeight: FontWeight.w500)),
            SizedBox(height: 3,),
            Text("pineapple fruit cream",style: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.w300)),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 250,
                  child: Row(
                    children: [
                      Text(  snapshot.data.data.product[index].productQuantity,style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w500)),
                      SizedBox(width: 3,),
                      Text("*",style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                      SizedBox(width: 3,),
                      Text( "\$${snapshot.data.data.product[index].productPrice}",style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Text( "\$${snapshot.data.data.product[index].productPrice}",style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w500)),
                ),
              ],
            ),

                ],);
              }

            ),
            SizedBox(height: 10,),
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
                            child: Text("Item Total", style: TextStyle(color:Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w400))),
                        Expanded(
                            flex:1,
                            child: Text( "\$5000",
                              style: TextStyle(color:Colors.black,
                                  fontSize: 10,
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
                        child: Text('Discount', style: TextStyle(color:Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400))),
                    Expanded(
                        flex:1,
                        child: Text( "60% Off",
                          style: TextStyle(color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400)
                          ,)
                    ),
                  ],
                ),
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
                        child: Text('Taxes', style: TextStyle(color:Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400))),
                    Expanded(
                        flex:1,
                        child: Text( "\$600",
                          style: TextStyle(color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400)
                          ,)
                    ),
                  ],
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
                            child: Text("Delivery Charge", style: TextStyle(color:Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w400))),
                        Expanded(
                            flex:1,
                            child: Text( "FREE",
                              style: TextStyle(color:Colors.black,
                                  fontSize: 10,
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
                        child: Text('Grand Total', style: TextStyle(color:Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400))),
                    Expanded(
                        flex:1,
                        child: Text( "\$${snapshot.data.data.totalPrice}",
                          style: TextStyle(color: ColorUtils.redAppColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)
                          ,)
                    ),
                  ],
                ),
              ),
            ),

            Padding(
                padding: const EdgeInsets.only(bottom: 20.0,top: 10),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>OrderSummery()));

                  },
                  child: Container(

                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.transparent,
                      ),
                      child: Column(children: [
                        Container(
                          height: 30,
                          width: 360,
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey,),),
                          ),
                          child: Center(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Order Details: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Phone Number: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("1233445579",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("Ordered Id: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(snapshot.data.data.orderId.toInt().toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("Delivery to: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(snapshot.data.data.address1.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("Delivery Mode: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(snapshot.data.data.deliveryType,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                               Row(
                                children: [
                                  Text("Payment Mode: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(snapshot.data.data.paymentMode,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("Order Status : ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(snapshot.data.data.orderStatus,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300)),
                                ],
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
                                            snapshot.data.data.orderDate
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300)),
                                        Text(" at ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300)),
                                        Text(
                                            snapshot.data.data.orderTime
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300)),
                                      ],
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),


                      ])),
                )),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xff61CE70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () {},
                child: Text(
                  "ReOrder",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 13),
                ),
              ),
            ),
             SizedBox(
                                height: 20,
                              ),
            ],),
          );
        
      
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        }));
  }
}
