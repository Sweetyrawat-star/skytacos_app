
import 'package:flutter/material.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';

class SuccessfulPage extends StatefulWidget {
  String id;
  SuccessfulPage({this.id});
  @override
  _SuccessfulPageState createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage(
              "assets/food1.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Padding(
                 padding: const EdgeInsets.only(top:70.0),
                 child: Icon(Icons.check,size: 120,color: Colors.white,),
               ),
              SizedBox(height: 20,),
              Text("Thank you for\n your order!",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.w600),),
              SizedBox(height: 60,),


              CustomWidget.appButton(
                  width: MediaQuery.of(context).size.width,
                  context: context,
                  height: 50,
                  text: "Back To Home",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
