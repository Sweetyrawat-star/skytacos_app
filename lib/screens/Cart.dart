import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/models/GetAddToCartModel.dart';
import 'package:skystacos_app/screens/DeliveryScreen.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';


class Cart extends StatefulWidget {
  final String rewardPoint;
  final String nameOfProduct;
  final String productId;
  final String priceOfProduct;
  final List imageOfProduct;
  final String lengthOfProduct;
  final String productProfile;
  Cart(
      {this.rewardPoint,
        this.productId,
        this.imageOfProduct,
        this.priceOfProduct,
        this.nameOfProduct,
        this.lengthOfProduct,
        this.productProfile});
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double count = 1;
  ProgressDialog pr;
  @override
  void initState() {
    super.initState();
    getCartProduct();

  }

  String reward, totalReward;
  List productIndex = [];
  bool isLoading = false;
  int itemCount = 0;
  void add() {
    setState(() {
      itemCount++;
    });
  }

  void minus() {
    setState(() {
      itemCount--;
    });
  }

  Future<void> deleteItem() async {
    setState(() {
      pr.show();
    });
    var body = ({
     "cartId": widget.productId,
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    print("token" + "$token");
    String url = "http://skytacos.ouctus-platform.com/skystacos/v1/removecart";
  
    var jsonResponse;
    var response = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },body: body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Deleted Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => Cart(productId: widget.productId,)),
                (Route<dynamic> route) => false);
      } else {
        print("Error");
        setState(() {
          pr.hide();
        });
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        setState(() {
          pr.hide();
        });
      }
    }}
  showDeleteAlert(BuildContext context,item) {

    // set up the buttons
    Widget noButton = FlatButton(
      child: Text("No",style: TextStyle(color: Colors.black),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("Yes",style: TextStyle(color: Colors.black)),
      onPressed:  () {
        Navigator.pop(context);

        deleteUser(item['id']);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("Would you like to delete this product?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  deleteUser(userId) async {
    var url = "http://skytacos.ouctus-platform.com/skystacos/v1/removecart$userId";
    var response = await http.post(url,headers: {
      "Content-Type" : "application/json",
      "Accept" : "application/json"
    });
    if(response.statusCode == 200){
      this.fetchUser();
    }
  }
  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://skytacos.ouctus-platform.com/skystacos/v1/getcart";
    var response = await http.get(url);
    if(response.statusCode == 200){
      var items = json.decode(response.body)['data'];
      setState(() {
        productIndex = items;
        isLoading = false;
      });
    }else{
      setState(() {
        productIndex = [];
        isLoading = false;
      });
    }
  }


  Future<GetAddToCartModel> getCartProduct() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    print("token" + "$token");
    final url = "http://skytacos.ouctus-platform.com/skystacos/v1/getcart";
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response);
    if (response.statusCode == 200) {
      final jsonPropertyVault = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      var reward = jsonPropertyVault["data"][0]["rewardPoints"];
      print(reward);
      var totalReward = jsonPropertyVault["data"][0]["TotalRewardPoints"];
      print(totalReward);
      return GetAddToCartModel.fromJson(jsonPropertyVault);
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "Cart",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.only(top:15.0,left: 10),
          child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Image.asset("assets/images/slider-icon.png",height: 33,))),
        ),
      ),
      backgroundColor: Color(0xffF3F3F3),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          buildProductList(),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Container(
              margin: EdgeInsets.only(top: 0),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xff61CE70),
                padding: EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeliveryScreen()));
                },
                child: Text(
                  'Checkout',
                  style: TextStyle(fontStyle: FontStyle.normal, fontSize: 18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
                  padding: EdgeInsets.only(left: 20, right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/right.png",height: 40,),
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
                          Text(" ITEM",
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
                                    width: 190,
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
                                  //SizedBox(height: 10.0,),
                                  Container(
                                    width: 210,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:180,
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
                                      children : [
                                        Row(
                                          children: [
                                            Text(
                                                "\$${snapshot.data.data[index].productPrice}",
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
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
                                              //margin: EdgeInsets.only(top: 20),
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
                                                  GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        minus();
                                                      });
                                                    },
                                                    child: Text(
                                                      "-",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 18,
                                                          color:
                                                              Color(0xff61CE70)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    snapshot.data.data[index]
                                                        .productQuantity,
                                                    maxLines: 1,
                                                    softWrap: true,
                                                    overflow: TextOverflow.ellipsis,
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
                                                  GestureDetector(
                                                    onTap: (){
                                                      setState(() {
                                                        add();
                                                      });
                                                    },
                                                    child: Text(
                                                      "+",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff61CE70)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                             // showDeleteAlert(context,item);
                                              //deleteItem();
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0,),
                                            child: Image.asset(
                                              "assets/images/delete-icon.png",
                                              height: 20,
                                            ),
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
