import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';


class AddressScreen extends StatefulWidget {
  String address;
  AddressScreen({this.address});
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  var formattedDate;
  bool _isLoading = false;
  bool _isChecked = true;
  ProgressDialog pr;
  bool _validate = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController selectController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String confirmPassword, email, phoneNumber, username, password, age;
  bool isDataLoaded = false;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
  }
  Future<void> signIn() async {
    setState(() {
      pr.show();
    });
    var body = {"confirmPassword": confirmPassword.toString(),
      "name": username.toString(),
      "emailAddress": email.toString(),
      "phoneNumber": phoneNumber.toString(),
      "password": password.toString(),};
    String url = "http://skytacos.ouctus-platform.com/skystacos/v1/user";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse;
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      print("response body ${jsonResponse["token"]}");
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        var token1 = sharedPreferences.setString(
            "token", jsonResponse["token"].toString());

        print(token1);
        var token2 = sharedPreferences.getString("token");
        print(token2);
        Fluttertoast.showToast(
            msg: "Registered Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => HomeScreen()),
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
      /* else {
        setState(() {
          _isLoading = false;
        });
        print("response body ${response.body}");
      }
    }*/
    }}


  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff61CE70),
          title: Text(
            "Address",
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
        ),
        backgroundColor: Color(0xffF3F3F3),
       // resizeToAvoidBottomPadding: true,
        body: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: new Form(
                  key: _key,
                  autovalidate: _validate,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,bottom: 10,top: 10),
                          child: Text("Fill Your Details",style: TextStyle(color: ColorUtils.appColor,fontSize: 20,fontWeight: FontWeight.w600),),
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: _isChecked,
                              onChanged: (val) {
                                setState(() {
                                  _isChecked = val;
                                  if (val == true) {}
                                });
                              },
                            ),
                            InkWell(
                              child: Text(
                                "Ship to my place",
                                style:
                                    TextStyle(color: Colors.black, fontSize: 17),
                              ),
                              onTap: () {
                              },
                            ),
                          ],
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,

                            padding: EdgeInsets.only(left: 14,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            //color: Color(0x54FFFFFF),
                            child: TextField(
                              controller: nameController,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                    color: ColorUtils.lightBlue,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 14,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextField(
                              controller: emailController,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                  hintText: "PhoneNumber",
                                  hintStyle: TextStyle(
                                    color: ColorUtils.lightBlue,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 14,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextField(
                              controller: emailController,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                  hintText: "Address Zip Code",
                                  hintStyle: TextStyle(
                                    color: ColorUtils.lightBlue,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 14,),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      child: TextFormField(
                                       initialValue: widget.address,
                                        controller: selectController,
                                        style: TextStyle(color: Colors.black, fontSize: 16),
                                        decoration: InputDecoration(
                                            hintText: "select date and time",
                                            hintStyle: TextStyle(
                                              color: ColorUtils.lightBlue,
                                              fontSize: 16,
                                            ),
                                            border: InputBorder.none
                                        ),
                                      ),
                                    ),
                                   ]),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          'change now',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              ),
                                        )
                                    ),
                                  ],
                                )
                              ],
                            ),
                            ),
                          ),
                        SizedBox(height: 10,),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 14, ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextField(
                              //controller: messageController,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                  hintText: "Address 1",
                                  hintStyle: TextStyle(
                                    color: ColorUtils.lightBlue,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 14, ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextField(
                              //controller: messageController,
                              style: TextStyle(color: Colors.black, fontSize: 16),
                              decoration: InputDecoration(
                                  hintText: "Address 2",
                                  hintStyle: TextStyle(
                                    color: ColorUtils.lightBlue,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Padding(
                          padding: const EdgeInsets.only(left:4.0,right: 4.0),
                          child: CustomWidget.appButton(
                              width: MediaQuery.of(context).size.width,
                              context: context,
                              height: 50,
                              text: "Proceed",
                              onTap: () {

                              }),
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  // ignore: unused_element
  Widget _passwordField() {
    return Theme(
      data: ThemeData(primaryColor: Color(0xffA8A7A7)
        // primaryColorDark: Colors.red,
      ),
      child: Container(
        //height: 70,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Address 1",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Theme(
              data: new ThemeData(
                primaryColor: Color(0xffA8A7A7),
              ),
              child: TextFormField(
                onSaved: (val) => password = val,
                validator: (val) {
                  return val.length < 1 ? "Required" : null;
                },
                keyboardType: TextInputType.text,
                controller: passwordController,
                obscureText: true, //This will obscure text dynamically
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.black,
                      //width: 0.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffC6C6C6),
                      // width: 0.0w
                    ),
                  ),
                  hintText: 'Address 1',
                  hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  Widget _nameField() {
    return Container(
      // height: 150,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Name",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.0,
          ),
          Theme(
            data: new ThemeData(
              primaryColor: Color(0xffC6C6C6),
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: nameController,
              onSaved: (val) => username = val,
              // initialValue: "abc",
              validator: (val) {
                return val.length < 1 ? "Required" : null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C6C6),
                  ),
                ),
                hintText: 'Name',
                hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                // suffixIcon: Icon(Icons.mail,color: Colors.grey,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _phoneField() {
    return Container(
      // height: 150,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Phone Number",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.0,
          ),
          Theme(
            data: new ThemeData(
              primaryColor: ColorUtils.greyLightColor,
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneController,
              onSaved: (val) => phoneNumber = val,
            
              validator: (val) {
                return val.length < 1 ? "Required" : null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C6C6),
                  ),
                ),
                hintText: 'Phone Number',
                hintStyle: TextStyle(color: ColorUtils.greyLightColor),
            
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _emailField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Address 2",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.0,
          ),
          Theme(
            data: new ThemeData(
              primaryColor: Color(0xffC6C6C6),
            ),
            child: Container(
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                onSaved: (val) => email = val,
              
                validator: (val) {
                  return val.length < 1 ? "Required" : null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffC6C6C6),
                    ),
                  ),
                  hintText: 'Address 2',
                  hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element
  _confirmpasswordField() {
    return Container(
  
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Address zip code",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.0,
          ),
          Theme(
            data: new ThemeData(
              primaryColor: Color(0xffC6C6C6),
            ),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: confirmPasswordController,
              onSaved: (val) => confirmPassword = val,
             
              validator: (val) {
                return val.length < 1 ? "Required" : null;
              },
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffC6C6C6),
                  ),
                ),
                hintText: 'Address Zip Code',
                hintStyle: TextStyle(color: Color(0xffC6C6C6)),
               
              ),
            ),
          ),
        ],
      ),
    );
  }
}
