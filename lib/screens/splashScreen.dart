
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';
import 'dart:async';

import 'package:skystacos_app/screens/loginScreen.dart';
import 'package:skystacos_app/sharedpreference/store.dart';




class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool showImageWidget = false;
  @override
  void initState() {
    super.initState();
    getFunction();

  }

  Future<dynamic> getFunction() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("UserId");
    print("user id-----------------------------------------------------------------------" +"$store1");
    navigatorPage();

    return store1;
  }

  Future<void> navigatorPage() async {

    if (store1 == null) {
      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginPage(),
          )));
    } else {

      Timer(
          Duration(seconds: 3),
              () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen(),
          )));
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg1.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 220.0,right: 70,left: 70),
          child: Image.asset(
            "assets/images/logo.png",height: 150,
          ),
        ),
      ),
    );
  }
}


class MyClippers extends StatefulWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final double offset;
  final double height;
  const MyClippers(
      {Key key, this.image,this.textTop,this.height, this.textBottom, this.offset})
      : super(key: key);

  @override
  _MyClippersState createState() => _MyClippersState();
}

class _MyClippersState extends State<MyClippers> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 90);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 90);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
