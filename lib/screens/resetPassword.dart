
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:skystacos_app/screens/loginScreen.dart';



class ResetPasswordPage extends StatefulWidget {
  String userId;
  ResetPasswordPage({this.userId});
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  GlobalKey<FormState> _key = new GlobalKey();
  String confirmPassword, password;
  ProgressDialog pr;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool showPassword=false;
  bool _showPassword=false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    showPassword = true;
    _showPassword = true;
  }

  Future<void> signUp() async {
    setState(() {
      pr.show();
    });
    var body = ({
      "confirmPassword": confirmPassword.toString(),
      "newPassword": password.toString(),
      "userId": widget.userId,
    });
      String url = "http://skytacos.ouctus-platform.com/skystacos/v1/resetpassword";
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
            msg: "ResetPassword Successful",
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
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                          child: Image.asset("assets/images/back.png",height: 40,))),
                ),
                CustomWidget.buildLogoImageAndText(context: context,top: 0,text: "Reset Password"),
                SizedBox(height: 20),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 80),
                    child: _passwordField()),
                SizedBox(height: 20,),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 80),
                    child: _confirmpasswordField()),
                SizedBox(height: 30,),
                CustomWidget.appButton(
                    context: context,
                    height: 50,
                    width:  MediaQuery.of(context).size.width,
                    text: "Send",
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
                    /*onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordPage()));
                    }*/

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
              maxLength: 8,
              maxLengthEnforced: true,
              controller: passwordController,
              obscureText:
              _showPassword, //This will obscure text dynamically
              decoration: InputDecoration(
                counterText: "",
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
                        ? Icons.remove_red_eye_outlined:Icons.visibility_off,
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
   _confirmpasswordField() {
    return
       Container(
        // height: 150,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Confirm Password",style: TextStyle(fontWeight: FontWeight.w500),),
            SizedBox(height: 10.0,),
            Theme(
              data: new ThemeData(
                primaryColor: Color(0xffC6C6C6),
              ),
              child: TextFormField(

                keyboardType: TextInputType.text,
                controller: confirmPasswordController,
                onSaved: (val) => confirmPassword = val,
                maxLength: 8,
                maxLengthEnforced: true,
                // initialValue: "abc",
                validator: (val) {
                  return val.length < 1 ? "Required" : null;
                },
                obscureText: showPassword,
                decoration: InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: Colors.black
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorUtils.greyLightColor,
                    ),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: ColorUtils.greyLightColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword
                          ? Icons.remove_red_eye_outlined:Icons.visibility_off,

                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                  // suffixIcon: Icon(Icons.mail,color: Colors.grey,),
                ),
              ),
            ),
          ],
        ),
    );
  }

}