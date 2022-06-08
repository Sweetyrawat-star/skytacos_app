import 'dart:convert';
import 'dart:io';
import 'package:html/parser.dart' show parse;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:http/http.dart' as http;
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:skystacos_app/models/ProductDescriptionModel.dart';
import 'package:skystacos_app/screens/Cart.dart';
import 'package:skystacos_app/screens/ProductComboScreen.dart';
import 'package:skystacos_app/sharedpreference/store.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetailPage extends StatefulWidget {
  final double rating;
  final String profileImage;
  final String nameOfProduct;
  final String priceOfProduct;
  final List imageOfProduct;
  final String productId;
  final String rewardPoint;
  final String description;
  ProductDetailPage(
      {this.rating,
      this.imageOfProduct,
      this.priceOfProduct,
      this.nameOfProduct,
      this.productId,this.description,this.profileImage,this.rewardPoint});
  @override
  _ProductDetailPageState createState() => new _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
 
  ApiHandler handler = ApiHandler();
  bool _isLoading = false;
  String customerId, productId, productName, productPrice, rewardPoint;
  ProgressDialog pr;
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

   Future<ProductDescriptionModel> getProductDescrpition() async {
   try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    print("token" + "$token");
    final url = "http://skytacos.ouctus-platform.com/skystacos/v1/productdetails/${widget.productId}";
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
   }catch(e){
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
    var response = await http.post(url, body: body,headers: {
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Cart(productId: widget.productId,)),
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
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff61CE70),
          title: Text(
            "Product-details",
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
              padding: const EdgeInsets.only(right: 10.0,top: 15,bottom: 5),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset("assets/images/c.png",height: 20,)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0,top: 15,bottom: 5),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text("2",style: TextStyle(color: Colors.white,fontSize: 18),)),
            ),
          ],
        ),
        body: FutureBuilder<ProductDescriptionModel>(
          future:  getProductDescrpition(),
          builder: (context, snapshot){
              
          if(snapshot.hasData)
          {
            var rating = double.parse(snapshot.data.data.productRating
            
            );
             var document = parse( snapshot.data.data.productDescription);
            return ListView(
              
      children: [
        Stack(
          children: <Widget>[
  
             Container(
      height: 200.0,
      child:  new Carousel(
        boxFit: BoxFit.fill,
        images: snapshot.data.data.images.map(( url) {
          return new NetworkImage("http://skytacos.ouctus-platform.com/$url");
        }).toList(),
        autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
     animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        dotColor: ColorUtils.appColor,
        indicatorBgPadding: 2.0,
      ),
    ),      
            
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
              ),
              snapshot.data.data.productName   !=null?  Text(
                  snapshot.data.data.productName,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ):Text(""),
              snapshot.data.data.categoryName   !=null?  Text(
                snapshot.data.data.categoryName,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.lightBlue),
              ): Text(""),
              SizedBox(
                height: 5.0,
              ),
             SmoothStarRating(
                rating: rating != null?rating: 3.5,
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
              SizedBox(
                height: 10.0,
              ),
             Container(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          snapshot.data.data.productPrice!=null? Text("\$${ snapshot.data.data.productPrice}",
              style: TextStyle(
                  color: ColorUtils.redAppColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w800)):Text(""),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: CustomWidget.appButton(
                height: 40,
                width: 140,
                context: context,
                text: "Add To Cart",
                size: 16,
                onTap: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=> ProductComboScreen(productId: snapshot.data.data.productId.toString(),)));
                  //addToCart();
                }),
          ),
        ],
      ),
    ),
              builButton(),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "You can add more item",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10.0,
              ),
              document.body.text!=null? Text(
               document.body.text,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorUtils.lightBlue),
              ):Text(""),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ],
    );

          }else{
            return Center(
              child: CircularProgressIndicator()
            );
          }
        },),
        );
  }
 
  

  Widget builButton() {
    return Container(
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomWidget.appButton(
              height: 30,
              width: 110,
              context: context,
              text: "Description",
              size: 13,
              onTap: () {
              }),
          Container(
              height: 30,
              width: 110,
              decoration: BoxDecoration(
                border: Border.all(color: ColorUtils.greyLightColor),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(
                child: Text("Review(0)",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorUtils.greyLightColor)),
              )),
        ],
      ),
    );
  }
}

