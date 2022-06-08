import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/models/getprofileuser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:skystacos_app/screens/loginScreen.dart';
import 'package:skystacos_app/screens/EditProfileScreen.dart';
import 'package:skystacos_app/sharedpreference/store.dart';

class ProfileScreen extends StatefulWidget {
  String image, userId, phoneNumber, email;
  ProfileScreen({this.image,this.userId,this.phoneNumber,this.email});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String image, userId, phoneNumber, email;

  bool circular = false;
  bool isDataLoaded = false;
  bool isLoading = false;
  File _image;
  PickedFile _pickedFile;
  final ImagePicker imagePicker = ImagePicker();
  ProgressDialog pr;
  @override
  void initState() {
    super.initState();
  }
   Future<void> LogOut() async {
    setState(() {
      pr.show();
    });
    String url = "http://skytacos.ouctus-platform.com/skystacos/v1/userlogout";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");

    var jsonResponse;
    var response = await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $store1"
    });
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        var token2 = sharedPreferences.getString("token");
        print(token2);
        Fluttertoast.showToast(
            msg: "LogOut Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => LoginPage()),
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
  Future<ProfileModel> getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    final url = "http://skytacos.ouctus-platform.com/skystacos/v1/user";
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $store1"
    });
    print(response);
    if (response.statusCode == 200) {
      final jsonPropertyVault = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      return ProfileModel.fromJson(jsonPropertyVault);
    } else {
      throw Exception();
    }
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.only(top:15.0,left: 10),
          child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/images/slider-icon.png",height: 33,))),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              setState(() {
                   LogOut();
                
              });
            },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(children: [
              Icon(
                Icons.login,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text("Logout"),

            ],),
                      ),
          )
        

        ],
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfileUserScreen(
                      name: widget.userId.toString(),
                      profileImage: widget.image.toString(),
                      phoneNumber:
                      widget.phoneNumber.toString(),
                    )));
          },
          child: FutureBuilder<ProfileModel>(
            future: getProfile(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width  ,
                    color: Color(0xffEFEFEF),
                    height: 200,
                    padding: EdgeInsets.all(30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white ,
                            backgroundImage: snapshot.data.data.profileImage.toString() == null?AssetImage("assets/images/dummy_user_profile.png")
                                : NetworkImage(ApiHandler.url+snapshot.data.data.profileImage.toString()),
                          ),
                          SizedBox(height: 10.0,),
                          Text(widget.userId,style: TextStyle(color: ColorUtils.appColor,fontSize: 18,fontWeight: FontWeight.w600),),
                        ])),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                                color: Color(0xff949494),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10.0),
                          snapshot.data.data.firstName.toString() ==
                              null
                              ? Text("")
                              : Text(
                            snapshot.data.data.firstName.toString(),
                            style: TextStyle(
                                color:
                                Color(0xff666666),
                                fontSize: 18,
                                fontWeight:
                                FontWeight.w600),
                          ),
                          Divider(
                            color: Color(0xffE0DFE2),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            "Phone Number",
                            style: TextStyle(
                                color: Color(0xff949494),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10.0),
                          snapshot.data.data.phoneNumber ==
                              null
                              ? Text("")
                              : Text(
                            snapshot.data.data.phoneNumber.toString(),
                            style: TextStyle(
                                color:
                                Color(0xff666666),
                                fontSize: 18,
                                fontWeight:
                                FontWeight.w600),
                          ),
                          Divider(
                            color: Color(0xffE0DFE2),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            
          ))
    );
  }

  
}
