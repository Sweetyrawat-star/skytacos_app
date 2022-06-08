import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/models/categorymodel.dart';
import 'package:skystacos_app/screens/Cart.dart';
import 'package:skystacos_app/screens/ProductDetailScreen.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  final int id;
  final customerId;
  final String categoryName;
  ProductList(
      {this.id,
      this.customerId,
      this.categoryName,
     });

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool _isLoading = false;
  String customerId, productId, productName, productPrice, rewardPoint;
  ProgressDialog pr;
  String addProductCart;

  Future<void> addToCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    print("token" + "$token");
    setState(() {
      pr.show();
    });
    var body = ({
      //"customerId": store1.toString(),
      "productId": addProductCart.toString(),
    });
    String url = "http://skytacos.ouctus-platform.com/skystacos/v1/addcart";
    var jsonResponse;
    var response = await http.post(url, body: body, headers: {
      // HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Product Add To Cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Cart()),
            (Route<dynamic> route) => false);
      } else {
        print("respopnse body---------$body");
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
    }
  }

  Future<ProductCategoryIdModel> getProductCategory() async {
     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var customerId= sharedPreferences.getInt("categoryId");
    print("categoryId" + "${customerId}");
    final url =
        "http://skytacos.ouctus-platform.com/skystacos/v1/product/${widget.customerId}";
    final response = await http.get(
      url,
    );
    print(response);
    if (response.statusCode == 200) {
      final getProduct = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return ProductCategoryIdModel.fromJson(getProduct);
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      appBar: AppBar(
        backgroundColor: ColorUtils.appColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Product",
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10),
          child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {

                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/images/slider-icon.png",
                    height: 33,
                  ))),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0, top: 10, bottom: 5),
            child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/images/search.png",
                  height: 40,
                )),
          ),
        ],
      ),
      body: ListView(
        children: [
          buildProductList(),
        ],
      ),
    );
  }

  buildProductList() {
    return FutureBuilder(
      future: getProductCategory(),
      builder: (BuildContext context,
          AsyncSnapshot<ProductCategoryIdModel> snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                child: SizedBox(
                  width: 340,
                  child: Text(widget.categoryName,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: ColorUtils.brownColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.data.length,
                padding: EdgeInsets.all(10.0),
                itemBuilder: (BuildContext context, int index) {
                  addProductCart = snapshot.data.data[index].productId.toString();
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                        productId: snapshot
                                            .data.data[index].productId
                                            .toString(),
                                        
                                      )));
                        },
                        child: Container(
                            height: 100,
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
                                      image: NetworkImage(ApiHandler.url +
                                          snapshot.data.data[index].productProfile
                                              .toString()),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        snapshot.data.data[index].productName,
                                        softWrap: false,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    SmoothStarRating(
                                      rating: snapshot.data.data[index].productRating != null?
                                      snapshot.data.data[index].productRating: 3.5,
                                      color: Colors.orange,
                                      borderColor: Colors.orange,
                                      size: 15,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      defaultIconData: Icons.star_border,
                                      starCount: 5,
                                      allowHalfRating: false,
                                      spacing: 2.0,
                                    ),
                                    Container(
                                      width: 210,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                             snapshot.data.data[index].productPrice.toString()!=null? SizedBox(
                                                width:40,
                                                child: Text(
                                                    "\$${snapshot.data.data[index].productPrice.toString()}",
                                                    softWrap: true,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: ColorUtils.redAppColor,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500)),
                                              ):Text(""),
                                              SizedBox(
                                                width: 10.0,
                                              ),

                                             
                                                        snapshot.data.data[index]
                                                            .productOffPrice!=null? Row(
                                                children: [
                                                  SizedBox(
                                                
                                                    child: snapshot.data.data[index]
                                                            .productOffPrice!=null?Text(
                                                        snapshot.data.data[index]
                                                            .productOffPrice.toString(),
                                                        softWrap: true,
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color:
                                                                ColorUtils.brownColor,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500)):Text(""),
                                                  ),
                                                  Text("% off",
                                                      style: TextStyle(
                                                          color:
                                                              ColorUtils.brownColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ):Text(""),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Container(
                                                  height: 30,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: ColorUtils
                                                            .greyLightColor),
                                                    borderRadius:
                                                        BorderRadius.circular(0.0),
                                                  ),
                                                  child: RaisedButton(
                                                    textColor: ColorUtils.appColor,
                                                    color: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    onPressed: () {
                                                     // addToCart();
                                                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                        productId: snapshot
                                            .data.data[index].productId
                                            .toString(),
                                        
                                      )));
                                                    },
                                                    child: Text(
                                                      "View",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ])),
                      ));
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
