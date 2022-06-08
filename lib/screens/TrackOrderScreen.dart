import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "Track Order  ",
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
      body: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 10,top: 10,bottom: 40),
              child: Container(
                width: 50,
                height: 490,

                decoration: BoxDecoration(
                    color: Colors.red,
                  borderRadius: BorderRadius.circular(40.0),

                ),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0)),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffB8EEBF),
                                Color(0xffB3ECBA),
                                Color(0xff7DD889),
                              ]
                          )
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 60,

                      decoration: BoxDecoration(
                          color: Colors.white,

                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          colors: [
                            Color(0xffB8EEBF),
                            Color(0xffB3ECBA),
                            Color(0xff7DD889),
                          ]
                        )
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 120,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffB8EEBF),
                                Color(0xffB3ECBA),
                                Color(0xff7DD889),
                              ]
                          )
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 80,

                      decoration: BoxDecoration(
                          color: Colors.white,

                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffB8EEBF),
                                Color(0xffB3ECBA),
                                Color(0xff7DD889),
                              ]
                          )
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xffC8C8C8),
                                Color(0xffEFEFEE),
                                Color(0xffAFAFAE),
                              ]
                          )
                      ),
                    ),
                  ],
                ),
              ),

            ),Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 40),
              child: Container(
                width: 10,
                height: 490,

                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(40.0),

                ),
                child: Column(
                  children: [
                    Container(
                      width: 10,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff39A110),
                                Color(0xff46B235),
                                Color(0xffC0E4C3),
                              ]
                          )
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      width: 50,
                      height: 50,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.0),

                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff39A110),
                                Color(0xff46B235),
                                Color(0xffC0E4C3),
                              ]
                          )
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      width: 50,
                      height: 100,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.0),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff39A110),
                                Color(0xff46B235),
                                Color(0xffC0E4C3),
                              ]
                          )
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      width: 50,
                      height: 60,

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.0),

                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff39A110),
                                Color(0xff46B235),
                                Color(0xffC0E4C3),
                              ]
                          )
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      width: 50,
                      height: 140,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.0),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff39A110),
                                Color(0xff46B235),
                                Color(0xffC0E4C3),
                              ]
                          )
                      ),
                    ),
                  ],
                ),
              ),

            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 40),
              child: Container(
                width: 150,
                height: 490,
                //color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 80,
                      padding: EdgeInsets.only(top: 35,),
                      child: Text("DELIVERED",style: TextStyle(fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      width: 100,
                      height: 60,
                      padding: EdgeInsets.only(top: 25,),
                      child: Text("PREP",style: TextStyle(fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      width: 100,
                      height: 120,
                      padding: EdgeInsets.only(top: 50,),
                      child: Text("BAKE",style: TextStyle(fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      width: 150,
                      height: 80,
                      padding: EdgeInsets.only(top: 30,),

                      child: Text("QUALITY CHECK",style: TextStyle(fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      width: 100,
                      height: 150,
                      padding: EdgeInsets.only(top: 60,),
                      child: Text("DELIVERED",style: TextStyle(fontWeight: FontWeight.w600),),
                  
                ),] 
              ),

            )
            )],
        ),
      ),
    );
  }
}
