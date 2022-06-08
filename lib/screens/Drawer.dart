
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/screens/AboutUs.dart';
import 'package:skystacos_app/screens/Blog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skystacos_app/screens/OrderHistoryEx.dart';
import 'package:skystacos_app/screens/loginScreen.dart';
import 'package:skystacos_app/screens/ContactUs.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';
import 'package:skystacos_app/screens/ProfileScreen.dart';
import 'package:skystacos_app/sharedpreference/store.dart';


class DrawerUtil extends StatefulWidget {
  String image, name, phoneNumber, email;
  DrawerUtil({this.image,this.name,this.phoneNumber,this.email});
  @override
  _DrawerUtilState createState() => _DrawerUtilState();
}

class _DrawerUtilState extends State<DrawerUtil> {


 String image,name,email,phone;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getBanner();
    // _fetchData();
  }
     
  drawerHeader(){
    return Container(
      height: 120.0,
      decoration: BoxDecoration(
          color: ColorUtils.appColor,
          border: Border(
              bottom: BorderSide(
                  color: Colors.grey[300],
                  width: 0.5
              )
          )
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right:10.0,top: 10.0),
              child: GestureDetector(child: Icon(Icons.close,color: Colors.white,size: 30,),
                onTap: (){
                  Navigator.pop(context);
                },),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white ,
                  backgroundImage: widget.image == null?AssetImage("assets/images/dummy_user_profile.png")
                      : NetworkImage(ApiHandler.url+widget.image.toString()),
                ),
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Text("John Deo",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),
                              ),*/
                      widget.name.toString() ==
                          null
                          ? Text("")
                          : Text(
                        widget.name.toString(),
                        style: TextStyle(
                          color:
                          Colors.white,
                        ),
                      ),
                      SizedBox(height: 5.0,),
                     widget.email.toString() ==
                          null
                          ? Text("")
                          : Text(
                        widget.email.toString(),
                        style: TextStyle(
                            color:
                            Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
   
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: ListView(
        children: <Widget>[
          drawerHeader(),
          _buildDrawerItems(text: 'Home',
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>HomeScreen()));
            }
          ),
          _buildDrawerItems(text: 'Profile',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProfileScreen(image: widget.image.toString(),
                  userId: widget.name.toString(),phoneNumber: widget.phoneNumber.toString(),)));
              }
          ),
          _buildDrawerItems(text: 'My Order',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MyOrderHistoryEx()));
              }
          ),
          // _buildDrawerItems(text: 'Order History',
          //     onTap: (){
          //       Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrderHistory()));
          //     }
          // ),
          _buildDrawerItems(text: 'About',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AboutUs()));
              }
          ),
          _buildDrawerItems(text: 'Contact Us',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ContactUs()));
              }
          ),
          _buildDrawerItems(text: 'Blog',
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Blog()));
              }
          ),
           _buildDrawerItems(text: 'Logout',
              onTap: (){
                setState(() {
                  showAlertDialog( ctxt: context);
                });
                
                
              }
          ),

        ],
      ),
    );
  }
  


  _buildDrawerItems({ String text, GestureTapCallback onTap}){
    return GestureDetector(
      onTap: onTap,
      child:Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xffE4E4E4))),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
              child: Text(text,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),
        ),
      )
     
    );
  }
  showAlertDialog({BuildContext ctxt}) {
  Future<void> onLogoutClicked() async {  
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    String url = "http://dev.swiftassets.net/public/api/logout";

    var jsonResponse;
    var response = await http.post(url, headers: {
    
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      if (jsonResponse != null) {
        var token2 = sharedPreferences.getString("token");
        print(token2);
          sharedPreferences.clear();
        Fluttertoast.showToast(
            msg: "LogOut Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
                Navigator.of(ctxt).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()),
                (Route<dynamic> route) => false);
      } else {
                print("Error");
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);

      }
    }}
    
    // NetworkUtil().bearerToken();
   
  

  Widget cancelButton = FlatButton(
    child: Text(
      "Cancel",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    onPressed: () {
      Navigator.pop(ctxt);
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "Logout",
      style: TextStyle(color: Colors.black),
    ),
    onPressed: () {
      onLogoutClicked();
     
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Log Out App!"),
    content: Text(
      "Do you want to Log Out from the app?",
      style: TextStyle(color: Colors.grey),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: ctxt,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

}
