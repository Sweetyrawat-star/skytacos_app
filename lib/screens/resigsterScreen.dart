import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:skystacos_app/screens/loginScreen.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();
  var formattedDate;
  bool _isLoading = false;
  ProgressDialog pr;
  bool _validate = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String confirmPassword, email, phoneNumber, username, password, age;
  bool isDataLoaded = false;
 

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
    String url = "http://skytacos.ouctus-platform.com/skystacos/v1/userregister";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonResponse;
    var response = await http.post(url, body: body);
     if (response.statusCode==422) {

    } else {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      print("response body ${jsonResponse["token"]}");
       String status = jsonResponse["status"];
      print(status);
      if (jsonResponse != null&& status == "Success"&& response.statusCode !=422) {
        setState(() {
          _isLoading = false;
        });

        var token1 = sharedPreferences.setString(
            "token", jsonResponse["token"].toString());

        print(token1);
        var token2 = sharedPreferences.getString("token");
        print(token2);
        Fluttertoast.showToast(
            msg: status,
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
      }
       else {
        print("respopnse body---------$body");
        print("Error");
        setState(() {
          pr.hide();
        });
        Fluttertoast.showToast(
            msg: status,
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


  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return new Scaffold(
        backgroundColor: Color(0xffF3F3F3),
        //resizeToAvoidBottomPadding: true,
        body: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/bg2.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
                child: new Form(
              key: _key,
              autovalidate: _validate,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    CustomWidget.buildLogoImageAndText(
                        context: context, top: 0, text: "Sign Up"),
                    SizedBox(height: 15),
                    ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 96),
                        child: _nameField()),
                    ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 96),
                        child: _phoneField()),
                    ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 96),
                        child: _emailField()),
                    ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 96),
                        child: _passwordField()),
                    ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 96),
                        child: _confirmpasswordField()),
                    SizedBox(
                      height: 20,
                    ),
                    CustomWidget.appButton(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      context: context,
                      text: "Sign Up",
                      size: 18,
                      onTap: () {
                        final loginForm = _key.currentState;
                        if (loginForm.validate()) {
                          loginForm.save();
                          signIn();
                          //register();
                        } else {
                          print("rrrrrrr");
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              " Sign In",
                              style: TextStyle(
                                  color: Color(0xffF51B2B),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ))));
  }

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
              "Password",
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
                  return val.length < 8 ? "Enter 8 digit number" : null;
                },
                keyboardType: TextInputType.text,
                controller: passwordController,
                maxLength: 15,
                maxLengthEnforced: true,
                obscureText: true, //This will obscure text dynamically
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffC6C6C6),
                    ),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameField() {
    return Container(
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
              validator: (val) {
                return val.length < 1 ? " Name is required" : null;
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _phoneField() {
    return Container(
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
              maxLength: 10,

              onSaved: (val) => phoneNumber = val,
              validator: (val) {
                return val.length < 10 ? "Enter 10 digit number" : null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                counterText: "",
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

  Widget _emailField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
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
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              onSaved: (val) => email = val,
              validator: (val) {
                return val.length < 1 ? "Enter your email" : null;
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
                hintText: 'sample@emailid.com',
                hintStyle: TextStyle(color: Color(0xffC6C6C6)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _confirmpasswordField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Confirm Password",
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
              maxLength: 15,
              maxLengthEnforced: true,
              validator: (val) {
                return val.length < 8 ? "Enter 8 digit password" : null;
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
                hintText: 'Password',
                hintStyle: TextStyle(color: Color(0xffC6C6C6)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
