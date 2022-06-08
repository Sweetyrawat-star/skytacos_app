import 'dart:convert';
import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/Utils/ListUtils.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/models/DeliveryType.dart';
import 'package:skystacos_app/models/GetAddToCartModel.dart';
import 'package:skystacos_app/screens/DineIn.dart';
import 'package:skystacos_app/screens/SuccessfulPage.dart';
import 'package:skystacos_app/screens/SummeryScreen.dart';
import 'package:skystacos_app/screens/selfDeliveryScreen.dart';
import 'package:skystacos_app/sharedpreference/store.dart';


class DeliveryScreen extends StatefulWidget {
  final String rewardPoint;
  final String nameOfProduct;
  final String productId;
  final String priceOfProduct;
  final List imageOfProduct;
  final String lengthOfProduct;
  final String productProfile;
  6DeliveryScreen(
      {this.rewardPoint,
        this.productId,
        this.imageOfProduct,
        this.priceOfProduct,
        this.nameOfProduct,
        this.lengthOfProduct,
        this.productProfile});


  @override
  _DeliveryScreenState createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen>
     {

  String deliveryType2, deliverType1, deliveryType3, token;
   int selectedIndex ;
  var formattedDate;
  var formattedTime;
  String date;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _date = new TextEditingController();
  TextEditingController time = new TextEditingController();
  @override
  void initState() {
    super.initState();
    getDeliveryType();
  }
  Future<DeliveryTypeModel> getDeliveryType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token2 = sharedPreferences.getString("token");
    print(token2);
    print(
        "token" +
            "$token2");
    final url = "http://skytacos.ouctus-platform.com/skystacos/v1/deliverytype";
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $store1"
    });
    print(response);
    if (response.statusCode == 200) {
      final jsonPropertyVault = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      setState(() {
        deliverType1 = jsonPropertyVault["data"][0]["deliveryId"].toString();
        print("banner Heading $deliverType1");
        deliveryType2 = jsonPropertyVault["data"][1]["deliveryId"].toString();
        print("bannerImage $deliveryType2");
        deliveryType3 = jsonPropertyVault["data"][2]["deliveryId"].toString();
        print("banner Text $deliveryType3");
      });

      return DeliveryTypeModel.fromJson(jsonPropertyVault);
    } else {
      throw Exception();
    }
  }
  Future<GetAddToCartModel> getCartProduct() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("UserId");
    print(
        "user id" +
            "$store1");
    final url =
        "http://skytacos.ouctus-platform.com/skystacos/v1/getcart/$store1";
    final response = await http.get(url,/*headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    }*/);
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
  List image = [
    "assets/images/Home-Dellivery.png",
    "assets/images/Self-Pick-Up.png",
    "assets/images/Dine-In.png",
  ];

  List nameOfDelivery = [
    "Home Delivery",
    "Self Pick Up",
    "Dine In",
  ];
  var dateclick;
  var timeclick;
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: ColorUtils.appColor,
              ),
            ),
            child: child,
          );
        },
        lastDate: DateTime(2100));
    formattedDate = "${picked.year}-${picked.month}-${picked.day}";
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print(selectedDate);
        dateclick = DateFormat.yMMMd().format(picked);
        _date.value = TextEditingValue(text: dateclick.toString());
      });
    } else {
      print("click outside of datepicker");
    }
  }
  Future<Null> selectTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    showTimePicker(
      context: context,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorUtils.appColor,
            ),
          ),
          child: child,
        );
      },

      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),

    ).then((TimeOfDay myvalue) {
      formattedTime = "${now.hour}:${now.minute}";
      if (myvalue != null) {
        setState(() {
          selectedTime = myvalue;
          print(selectedTime);
         // myvalue.format(context);

          time.value = TextEditingValue(text: myvalue.format(context));
          myvalue = selectedTime;
        });
      } else {
        print("click outside of timepicker");
      }
    });
  }
  final selected = DateFormat.jm();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUtils.appColor,
          title: Text("Delivery",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          leading:  Padding(
            padding: const EdgeInsets.only(top:10.0,left: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/images/slider-icon.png",height: 33,))),
          ),
        ),
        backgroundColor: Color(0xffF3F3F3),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/banner.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),),
                  selectBuildContainer(),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                )
              ],
            ),
          ],
        ));
  }

  selectBuildContainer(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: image.length,
     itemBuilder: (BuildContext context ,int index){
       return GestureDetector(
         onTap:
          (){
          setState(() {
            if(index == 0){
              setState(() {
              birthday(context:context,onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> SummeryScreen()));});
            });
            }else if(index==1){
         setState(() {
           birthday(context:context,onTap: (){Navigator.push(context, MaterialPageRoute(
               builder: (context)=>
                   SelFDelivery(date: dateclick.toString().replaceAll("00:00:00:000", ""),
                       time: selectedTime.toString().replaceFirst("TimeOfDay", "").replaceAll("()", ""))));});

         });
            }else{
            setState(() {
              birthday(context:context,onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  DineIn(date: dateclick.toString().replaceAll("00:00:00:000", ""),time: selectedTime.toString().replaceFirst("TimeOfDay", "").replaceFirst("()", ""))));});
            });
            }
             selectedIndex = index;
          });
        },
         child: Padding(
           padding: const EdgeInsets.only(left:15.0,right: 15.0,top: 15),
           child: Card(
             elevation: 3,
             child: Container(
               height: 80,
               decoration: BoxDecoration(
                 color:  selectedIndex == index
                     ? ColorUtils.appColor
                     : Colors.white,
                 borderRadius: BorderRadius.circular(5.0),
               ),
               padding: const EdgeInsets.only(left:15.0,right: 15.0),
               width: MediaQuery.of(context).size.width,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Container(
                     height: 60,
                     width: 70,
                     decoration: BoxDecoration(
                       image: DecorationImage(
                           image: AssetImage(
                               image[index],
                           ),
                           fit: BoxFit.fitHeight),
                     ),
                   ),
                   SizedBox(width: 40.0,),
                   Container(
                     width: 180,
                     child: Text(
                         nameOfDelivery[index],
                         //"Self Pick Up",
                         style: TextStyle(color:  selectedIndex == index ?
                              Colors.white
                             : ColorUtils.appColor,fontSize: 18,
                             fontWeight: FontWeight.w600)),
                   ),
                 ],
               ),
             ),
           ),
         ),
       );
     },
    );
  }
  buildProductList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ListUtils.listOfCartImages.length,
      padding: EdgeInsets.all(10.0),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SuccessfulPage(id: deliveryType2.toString(),)));
              },
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
                            image: AssetImage(
                              ListUtils.listOfCartImages[index],
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ListUtils.listOfcart[index],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            width: 210,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(ListUtils.listOftitle[index],
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),

                          Container(
                            width: 210,
                            child: Row(
                              children: [
                                Text(ListUtils.listOfProductPrice[index],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 25,
                                  //margin: EdgeInsets.only(top: 20),
                                  width: 60,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffC6C6C6)),
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "-",
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18,
                                            color: Color(0xff61CE70)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "2",
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff61CE70)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "+",
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Color(0xff61CE70)),
                                      ),
                                    ],
                                  ),
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
    );
  }

  birthday({BuildContext context,onTap}) {
    // set up the buttons
    Widget submitButton = Container(
      padding: EdgeInsets.only(left:40,right: 90),
      child: Center(
        child: FlatButton(
          onPressed: onTap,
            color: ColorUtils.appColor,
            child: Text(
              "CONTINUE",
              style: TextStyle(color: Colors.white),
            ),
            ),
      ),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              padding: EdgeInsets.only(left: 10.0),
              height: 40.0,
              color: ColorUtils.appColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Select Time And Date",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              )),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Form(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                          padding: EdgeInsets.only(top: 5),
                          height: 40.0,
                          width: 180.0,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _date,
                              keyboardType: TextInputType.datetime,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      )),
                                  labelText: "Select Date ",
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => selectTime(context),
                      child: Container(
                          padding: EdgeInsets.only(top: 5),
                          height: 40.0,
                          width: 180.0,
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: time,
                              keyboardType: TextInputType.datetime,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              onFieldSubmitted: (_) =>
                                  FocusScope.of(context).nextFocus(),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      )),
                                  labelText: "Select Time ",
                                  labelStyle: TextStyle(color: Colors.grey)),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            submitButton,
          ],
        );
      },
    );
  }
}
