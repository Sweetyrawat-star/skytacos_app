
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:skystacos_app/screens/temparoryPassword.dart';



class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  GlobalKey<FormState> _key = new GlobalKey();
  String email, password,otp ,userId;
  ProgressDialog pr;
  TextEditingController emailController = TextEditingController();
  bool _isLoading=false;

  @override
  void initState() {
    super.initState();
  }
  Future<void> otpMethod() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "emailAddress": email.toString(),
    });
    String url = "http://skytacos.ouctus-platform.com/skystacos/v1/forgetpassword";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse;
    var response = await http.post(url, body: body);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("otp", jsonResponse["data"]["otp"].toString());
        sharedPreferences.setString("userId",jsonResponse["data"]["userId"].toString());
        print("otp " +
            "${jsonResponse["data"]["otp"].toString()}");
        print("userId" +
            "${jsonResponse["data"]["userId"].toString()}");
         otp = sharedPreferences.getString("otp");
        print("otp" + "$otp");
        userId = sharedPreferences.getString("userId");
        print("userId" + "$userId");
       /* var id = sharedPreferences.setString("UserId", jsonResponse["data"]["data"]["UserId"].toString());
        print(" id $id");*/
       /* var token2 = sharedPreferences.getString("token");
        print(token2);*/
        Fluttertoast.showToast(
            msg: "LogIn Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarPage()));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => TemparoryPasswordPage(userId: userId.toString(),otp: otp.toString(),)),
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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg2.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child:SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                      child: Image.asset("assets/images/back.png",height: 40,)),
                ),
                CustomWidget.buildLogoImageAndText(context: context,top: 0,text: "Forgot Password"),
                SizedBox(height: 5),
                Text("Please enter your email",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 17)),
                Text(" we will send a temporary",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 17),),
                Text("password number",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 17),),
                SizedBox(height: 15),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 80),
                    child: _emailField()),
                SizedBox(height: 30),

                CustomWidget.appButton(
                  height: 50,
                    width: MediaQuery.of(context).size.width,
                    context: context,
                    text: "Send",
                    size: 18,
                   /* onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> TemparoryPasswordPage()));
                    }*/
                  onTap: () {
                    final loginForm = _key.currentState;

                    if (loginForm.validate()) {
                      loginForm.save();
                      otpMethod();
                      //forgotPassword();
                    } else {
                      print("rrrrrrr");
                    }
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
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