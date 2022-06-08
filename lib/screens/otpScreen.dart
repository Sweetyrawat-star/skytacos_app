import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';


class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/bg.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding:EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomWidget.buildLogoImageAndText(context: context,top: 30,text: "Verification Code"),
                SizedBox(height: 15),
                Text("SMS verification code has been",style: TextStyle(fontWeight:
                FontWeight.w500,color: Colors.grey,fontSize: 17)),
                Text("send to",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey,fontSize: 17),),
                SizedBox(height: 15),
                Text("+84 98 5234812",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    )),
                SizedBox(height: 25),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pin Code",style: TextStyle(fontWeight:
                      FontWeight.w500,color: Colors.black,fontSize: 17)),
                      OtpForm(),


                    ],
                  ),
                ),
                SizedBox(height: 45),
                CustomWidget.appButton(
                    height: 50,
                    width:  MediaQuery.of(context).size.width,
                    context: context,
                    text: "Submit",
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    }
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            width: 320,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50,
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black,
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      autofocus: true,
                      obscureText: true,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                                    onChanged: (value) {
                        nextField(value, pin2FocusNode);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black,),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      focusNode: pin2FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,                    
                      onChanged: (value) => nextField(value, pin3FocusNode),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black,),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      focusNode: pin3FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) => nextField(value, pin4FocusNode),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Theme(
                    data: new ThemeData(
                      primaryColor: Colors.black,),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      focusNode: pin4FocusNode,
                      obscureText: true,
                      style: TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        if (value.length == 1) {
                          pin4FocusNode.unfocus();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}