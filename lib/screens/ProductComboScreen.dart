import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:http/http.dart' as http;
import 'package:skystacos_app/models/ProductDescriptionModel.dart';
import 'package:skystacos_app/screens/Cart.dart';
import 'package:skystacos_app/sharedpreference/store.dart';

class ProductComboScreen extends StatefulWidget {
  final String rewardPoint;
  final String nameOfProduct;
  final String productId;
  final String priceOfProduct;
  final List imageOfProduct;
  final String lengthOfProduct;
  final String productProfile;
  final ValueSetter<RequiredChooseOptionFields> valueSetter;
  ProductComboScreen(
      {this.rewardPoint,
        this.valueSetter,
      this.productId,
      this.imageOfProduct,
      this.priceOfProduct,
      this.nameOfProduct,
      this.lengthOfProduct,
      this.productProfile});

  @override
  _ProductComboScreenState createState() => _ProductComboScreenState();
}

class _ProductComboScreenState extends State<ProductComboScreen> {
  bool isLoading = false;

  ProgressDialog pr;
  int itemCount = 0;
  String totalPrice;
     int selectedIndex ;




  @override
  void initState() {
    super.initState();
  }
  var sum;
  int count=0;
  var parsePrice,pass;
  List _selecteCategorys = List();
  List<AddOn> model = [];
  ProductDescriptionModel data = ProductDescriptionModel();
  void _onCategorySelected(bool selected, categoryId) {
    if (selected == true) {
      setState(() {
        _selecteCategorys.add(categoryId);

      });
    } else {
      setState(() {
        _selecteCategorys.remove(categoryId);


      });
    }
  }

  Future<ProductDescriptionModel> getProductDescrpition() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.getString("token");
      print("token" + "$token");
      final url =
          "http://skytacos.ouctus-platform.com/skystacos/v1/productdetails/${widget.productId}";
      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        var jsonPropertyVault = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        return ProductDescriptionModel.fromJson(jsonPropertyVault);
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
    }
    return ProductDescriptionModel();
  }

  Future<void> addToCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    print("token" + "$token");
    setState(() {
      pr.show();
    });
    var body = ({
      "customerId": store1.toString(),
      "productId": widget.productId.toString(),
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
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Product Add To Cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => Cart(
                      productId: widget.productId,
                    )),
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


  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
        backgroundColor: Color(0xffF3F3F3),
        appBar: AppBar(
          backgroundColor: Color(0xff61CE70),
          title: Text(
            "Product-Combo",
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 5),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    "assets/images/c.png",
                    height: 20,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 15, bottom: 5),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "2",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
          ],
        ),
        body: FutureBuilder<ProductDescriptionModel>(
          future: getProductDescrpition(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                 padding: EdgeInsets.all(10.0),
                children: [
                 snapshot.data.data.requiredChooseOptionFields.isNotEmpty? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xffeae8e6),
                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data.data.requiredChooseOption, style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),),
                            SizedBox(height:10),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount:  snapshot.data.data.requiredChooseOptionFields.length,
                          itemBuilder: (BuildContext context,int index){
                            if(count<1)
                            {
                               sum = double.parse(snapshot.data.data.productPrice.toString()).round();
                               count++;
                                  }


                                    return Padding(
                                      padding: const EdgeInsets.only(bottom:10.0),
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                             selectedIndex = index;


                                          });

                                      },
                                   child: Row(
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.only(left:20.0,),
                                           child: Container(
               height: 20,
               width:20,
               padding: EdgeInsets.all(5),
               decoration: BoxDecoration(
                 color:  selectedIndex == index
                     ? ColorUtils.appColor
                     : Color(0xffF3F3F3),
                     border: Border.all(color: selectedIndex == index
                     ? Colors.white
                     : Colors.grey,),
                 shape: BoxShape.circle
               ),
               ),
                                         ),
               SizedBox(width:20.0),
               Column(
                                children: [
                                  Row(
                                      children: [
                                        snapshot
                                            .data
                                            .data
                                            .requiredChooseOptionFields[index].requiredProduct
                                            !=
                                            null
                                            ? Text(
                                            snapshot
                                                .data
                                                .data
                                                .requiredChooseOptionFields[index].requiredProduct                                           ,
                                            style: TextStyle(
                                                color: ColorUtils
                                                    .lightBlue,
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight
                                                    .w300))
                                            : Text(""),
                                             snapshot
                                        .data
                                        .data
                                        .addOn[index]
                                        .addOnPrice !=
                                        null
                                        ? Text(
                                        snapshot
                                            .data
                                            .data
                                            .addOn[index]
                                            .addOnPrice,
                                        style: TextStyle(
                                            color: ColorUtils
                                                .lightBlue,
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight
                                                .w300))
                                        : Text(""),
                                      ],
                                  ),
                                ],
                              ),
               

                                       ],
                                   ),
                                      ),
                                    );
                                    
                          },
                        ),
                      ],
                    )
                       
                  ) : Text(""),
                  SizedBox(height:20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "You can add more item",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 28.0),
                        child: Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  snapshot.data.data.addOn.isNotEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.data.addOn.length,
                    //padding: EdgeInsets.all(10.0),
                    itemBuilder:
                        (BuildContext context, int index) {
                      return StatefulBuilder(
                        builder:(context, setter){
                          return CheckboxListTile(
                            controlAffinity:
                            ListTileControlAffinity.leading,
                            value: _selecteCategorys.contains(
                                snapshot.data.data.addOn[index]
                                    .addOnName),
                            checkColor: Colors.white,
                            activeColor: ColorUtils.appColor,
                            selected: true,
                            onChanged: (bool selected) {
                              _onCategorySelected(
                                  selected,
                                  snapshot.data.data.addOn[index]
                                      .addOnName);
                              if(selected == true){
                                setter(() {
                                  double val=double.parse(snapshot.data.data.addOn[index].addOnPrice);

                                      sum=sum+val.round();
                                           pass=sum;
                                  print(pass);
                                 // double val2 = double.parse(sum);
                                  //double val= double.parse(snapshot.data.data.addOn[index].addOnPrice);
                                  //parsePrice = val2 + val;
                                  // if(parsePrice> val2){
                                  //    pass  = parsePrice+val ;
                                  //   print(pass);
                                  // }

                                });
                              }
                              else if(selected == false){
                                setter(() {
                                  sum=sum-double.parse(snapshot.data.data.addOn[index].addOnPrice);
                                  pass=sum;
                                  print(pass);
                                    print(parsePrice);
                                });

                              }


                            },
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 185,
                                      child: snapshot
                                          .data
                                          .data
                                          .addOn[index]
                                          .addOnName !=
                                          null
                                          ? Text(
                                          snapshot
                                              .data
                                              .data
                                              .addOn[index]
                                              .addOnName,
                                          style: TextStyle(
                                              color: ColorUtils
                                                  .lightBlue,
                                              fontSize: 16,
                                              fontWeight:
                                              FontWeight
                                                  .w300))
                                          : Text(""),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    width: 50,
                                    child: snapshot
                                        .data
                                        .data
                                        .addOn[index]
                                        .addOnPrice !=
                                        null
                                        ? Text(
                                        snapshot
                                            .data
                                            .data
                                            .addOn[index]
                                            .addOnPrice,
                                        style: TextStyle(
                                            color: ColorUtils
                                                .lightBlue,
                                            fontSize: 16,
                                            fontWeight:
                                            FontWeight
                                                .w300))
                                        : Text(""),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      );
                    },
                  )
                      : Text("No Add Item Yet"),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                      padding: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Price",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                           pass != null? Text( "\$$pass",
                                style: TextStyle(
                                    color: ColorUtils.redAppColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800)):Text( "\$${snapshot.data.data.productPrice.toString()}",
                               style: TextStyle(
                                   color: ColorUtils.redAppColor,
                                   fontSize: 24,
                                   fontWeight: FontWeight.w800)),
                          ])),
                  SizedBox(
                    height: 30.0,
                  ),
                  buildRowButton(),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget buildRowButton() {
    return Container(
      //color: Colors.red,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 50,
              width: 155,
              decoration: BoxDecoration(
                color: Color(0xffD1D1D1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: Text("Back",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
              )),
          CustomWidget.appButton(
            height: 50,
            width: 155,
            context: context,
            text: "Next",
            onTap: () {
              addToCart();
            },
          ),
        ],
      ),
    );
  }
}
