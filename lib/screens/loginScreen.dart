import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';
import 'package:skystacos_app/screens/forgotPassword.dart';
import 'package:skystacos_app/screens/resigsterScreen.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email, password;
  bool _showPassword = false;
  ProgressDialog pr;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }


  Future<void> signUp() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "emailAddress": email.toString(),
      "password": password.toString(),
    });
    String url = "http://skytacos.ouctus-platform.com/skystacos/v1/login";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse;
    var response = await http.post(url, body: body);
    if (response.statusCode == 422) {
      // throw new Exception("Error while fetching data");
     Fluttertoast.showToast(
            msg: "Please Check Your email and password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        setState(() {
          pr.hide();
        });
    }else{
       jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      print("body$jsonResponse");
      String status = jsonResponse["status"];
      print(status);
      var msg = jsonResponse["message"];
      print(msg);
      if (jsonResponse != null&& status == "Success") {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("UserId", jsonResponse["data"]["data"]["UserId"].toString());
        sharedPreferences.setString("token",jsonResponse["data"]["token"].toString());
        print("token " +
            "${jsonResponse["data"]["token"].toString()}");
        print("UserId" +
            "${jsonResponse["data"]["data"]["UserId"].toString()}");
        var id = sharedPreferences.setString("UserId", jsonResponse["data"]["data"]["UserId"].toString());
        print(" id $id");
        var token2 = sharedPreferences.getString("token");
        print(token2);
        Fluttertoast.showToast(
            msg:status,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()));
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
            msg: msg,
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg2.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                CustomWidget.buildLogoImageAndText(
                    context: context, text: "Sign In", top: 10),
                SizedBox(height: 15),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 96),
                    child: _emailField()),
               /* SizedBox(
                  height: 5,
                ),*/
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 96),
                    child: _passwordField()),
               // SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()));
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomWidget.appButton(
                  width: MediaQuery.of(context).size.width,
                    context: context,
                    height: 50,
                    text: "Sign In",
                    size: 18,
                  onTap: () {
                    final loginForm = _key.currentState;

                    if (loginForm.validate()) {
                      loginForm.save();
                      signUp();
                    } else {
                      print("rrrrrrr");
                    }
                  },
                 ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  " or ",
                  style: TextStyle(color: ColorUtils.appDarkGreyColor, fontSize: 22),
                ),
                SizedBox(height: 10),
                googleFacebookButton(),
                SizedBox(height: 20),
                buildDontHaveAnAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDontHaveAnAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          child: Text(" Register",
              style: TextStyle(
                  color: ColorUtils.redAppColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
        )
      ],
    );
  }

  Widget googleFacebookButton() {
    return Container(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: EdgeInsets.all(
                10,
              ),
              height: 50,
              width: 155,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ColorUtils.greyLightColor),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/g.png",
                    height: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Google",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      )),
                ],
              )),
          Container(
              padding: EdgeInsets.all(
                10,
              ),
              height: 50,
              width: 155,
              decoration: BoxDecoration(
                color: ColorUtils.facebookColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/f.png",
                    height: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Facebook",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              )),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return Container(
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
              primaryColor: ColorUtils.greyLightColor,
            ),
            child: TextFormField(
              onSaved: (val) => password = val,
              validator: (val) {
                return val.length < 8 ? "Enter maximum 8 digit password" : null;
              },
              maxLength: 15,
              maxLengthEnforced: true,

              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText:
                  !_showPassword, //This will obscure text dynamically
              decoration: InputDecoration(
                //counterText: "",
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                border: new OutlineInputBorder(
                  borderSide: new BorderSide(
                    color: Colors.black,
                    //width: 0.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorUtils.greyLightColor,
                    // width: 0.0w
                  ),
                ),
                hintText: 'Password',
                hintStyle: TextStyle(color: ColorUtils.greyLightColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword
                        ? Icons.visibility_off
                        : Icons.remove_red_eye_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _emailField() {
    return Container(
      // height: 150,
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
              // initialValue: "abc",
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
                // suffixIcon: Icon(Icons.mail,color: Colors.grey,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


