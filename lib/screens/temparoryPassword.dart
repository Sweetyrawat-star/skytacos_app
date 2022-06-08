
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:skystacos_app/screens/resetPassword.dart';



class TemparoryPasswordPage extends StatefulWidget {
  String otp,userId;
  TemparoryPasswordPage({this.otp,this.userId});
  @override
  _TemparoryPasswordPageState createState() => _TemparoryPasswordPageState();
}

class _TemparoryPasswordPageState extends State<TemparoryPasswordPage> {

  GlobalKey<FormState> _key = new GlobalKey();
  String password;
  ProgressDialog pr;
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _showPassword = false;
  }

  Future<void> temparoryPassword() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "temporaryPassword": widget.otp,
      "userId": widget.userId,
      // "password": password.toString(),
    });
    String url = "http://skytacos.ouctus-platform.com/skystacos/v1/verify_temp";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var otp = sharedPreferences.getString("otp");
    print("otp" + "$otp");
    var userId = sharedPreferences.getString("userId");
    print("userId" + "$userId");
    var jsonResponse;
    var response = await http.post(
        url, body: body,/*headers: {
          "cookie": "otp =$password",
    }*/);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("response statusCode ${response.statusCode}");
      print("body$jsonResponse");
      if (jsonResponse != null) {
        setState(() {
        });
        Fluttertoast.showToast(
            msg: "Temporary password Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue[200],
            textColor: Colors.black,
            fontSize: 16.0);
              Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => ResetPasswordPage(userId: widget.userId,)),
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
    
    }}
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
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
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset("assets/images/back.png",height: 40,)),
                ),
                CustomWidget.buildLogoImageAndText(context: context,top: 0,text: "Temporary Password"),
                Text("Please fill your temporary",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 17)),
                Text("password here",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 17),),
                SizedBox(height: 15),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 80),
                    child: _passwordField() ),
                SizedBox(height: 30,),
                CustomWidget.appButton(
                    context: context,
                    height: 50,
                    width:  MediaQuery.of(context).size.width,
                    text: "Submit",
                    size: 18,
                  onTap: () {
                    final loginForm = _key.currentState;
                   

                    if (loginForm.validate()) {
                      loginForm.save();
                      temparoryPassword();
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

  Widget _passwordField() {
    return Container(
      //height: 70,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Password",style: TextStyle(fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Theme(
            data: new ThemeData(
              primaryColor: ColorUtils.grey_Color,
            ),
            child: TextFormField(
              onSaved: (val) => password = val,
              validator: (val) {
                return val.length < 1 ? "Required" : null;
              },
              keyboardType: TextInputType.text,
              controller: passwordController,
                obscureText:
                !_showPassword,
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

  Widget buildLogoImageAndText(){
    return Container(
      //color: Colors.red,
        padding: EdgeInsets.only(
          top: 30,
        ),
        // height: 170,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",height: 140,fit: BoxFit.fitHeight,
            ),
            Text("Forgot Password",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                )),
          ],
        ));
  }
  

}