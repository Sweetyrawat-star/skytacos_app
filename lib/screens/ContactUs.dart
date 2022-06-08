import 'package:flutter/material.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/Utils/custom_widget.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool open = false;
  bool open1 = false;
  bool open2 = false;
  bool open3 = false;

  bool visible = true;
  bool visible1 = true;
  bool visible2 = true;
  bool visible3 = true;
  bool containerVisible = false;
  bool containerVisible1 = false;
  bool containerVisible2 = false;
  bool containerVisible3 = false;
  void onVisible() {
    setState(() {
      visible = !visible;
    });
  }

  void onVisible3() {
    setState(() {
      visible3 = !visible3;
    });
  }

  void onVisible1() {
    setState(() {
      visible1 = !visible1;
    });
  }
  void onVisible2() {
    setState(() {
      visible2 = !visible2;
    });
  }

  void containerMyVisible() {
    setState(() {
      containerVisible = !containerVisible;
    });
  }
  void containerMyVisible1() {
    setState(() {
      containerVisible1 = !containerVisible1;
    });
  }
  void containerMyVisible2() {
    setState(() {
      containerVisible2 = !containerVisible2;
    });
  }
  void containerMyVisible3() {
    setState(() {
      containerVisible3 = !containerVisible3;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFEFEF),
      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "Contact Us",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),

        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,bottom: 10,top: 10),
            child: Text("Send a Message",style: TextStyle(color: ColorUtils.appColor,fontSize: 20,fontWeight: FontWeight.w600),),
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
                    hintText: "Email",
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
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 14, ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextField(
                controller: messageController,
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                    hintText: "Message",
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
                text: "Send",
                onTap: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen()));*/
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,bottom: 10,top: 20),
            child: Text("Contact Info",style: TextStyle(color: ColorUtils.appColor,fontSize: 20,fontWeight: FontWeight.w600),),
          ),
          Column(
            children: [
              Container(
                height: 35,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Sky's Los Angles",style: TextStyle(color: Color(0xff949494),fontSize: 16,fontWeight: FontWeight.w500),),
                    Text("Open Time",style: TextStyle(color: Color(0xff949494),fontSize: 16,fontWeight: FontWeight.w500),),
                    IconButton(icon: open==true?Icon(Icons.arrow_circle_up,
                      color: Color(0xff949494),):Icon(Icons.arrow_circle_down_outlined,color: Color(0xff949494),),onPressed:(){
                      setState(() {
                        onVisible();
                        containerMyVisible();
                      });

                    } )
                  ],
                ),
              ),
              visible == false
                  ? Visibility(
                  visible: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("5503 W Pico Blvd,Los\nAngeles,CA 90019"),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text("Daily"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:15.0),
                            child: Text("8AM To 10PM"),
                          ),
                        ]
                    ),
                  ))
                  : Container(),
            ],
          ),

          SizedBox(height: 20.0),
          Column(
            children: [
              Container(
                height: 35,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Sky's Los Angles",style: TextStyle(color: Color(0xff949494),fontSize: 16,fontWeight: FontWeight.w500),),
                    Text("Open Time",style: TextStyle(color: Color(0xff949494),fontSize: 16,fontWeight: FontWeight.w500),),
                    IconButton(icon: Icon(Icons.arrow_circle_up,color: Color(0xff949494),),onPressed:(){
                      setState(() {
                        onVisible1();
                        containerMyVisible1();
                      });

                    } )
                  ],
                ),
              ),
              visible1 == false
                  ? Visibility(
                  visible: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("5503 W Pico Blvd,Los\nAngeles,CA 90019"),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text("Daily"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:15.0),
                            child: Text("8AM To 10PM"),
                          ),
                        ]
                    ),
                  ))
                  : Container(),
            ],
          ),
          SizedBox(height: 20.0),
          Column(
            children: [
              Container(
                height: 35,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Sky's Los Angles",style: TextStyle(color: Color(0xff949494),fontSize: 16,fontWeight: FontWeight.w500),),
                    Text("Open Time",style: TextStyle(color: Color(0xff949494),fontSize: 16,fontWeight: FontWeight.w500),),
                    IconButton(icon: Icon(Icons.arrow_circle_up,color: Color(0xff949494),),onPressed:(){
                      setState(() {
                        onVisible2();
                        containerMyVisible2();
                      });

                    } )
                  ],
                ),
              ),
              visible2 == false
                  ? Visibility(
                  visible: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("5503 W Pico Blvd,Los\nAngeles,CA 90019"),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text("Daily"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:15.0),
                            child: Text("8AM To 10PM"),
                          ),
                        ]
                    ),
                  ))
                  : Container(),
            ],
          ),
          SizedBox(height: 20.0),
          Column(
            children: [
              Container(
                height: 35,
                width: 360,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:40.0),
                      child: Container(
                        width: 200,
                        //color: Colors.red,
                        padding: EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Phone",style: TextStyle(color: Color(0xff949494),fontSize: 16,fontWeight: FontWeight.w500),),
                            Text("Email",style: TextStyle(color: Color(0xff949494),fontSize: 16,fontWeight: FontWeight.w500),),

                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: IconButton(icon: Icon(Icons.arrow_circle_up,color: Color(0xff949494),),onPressed:(){
                            setState(() {
                              onVisible3();
                              containerMyVisible3();
                            });

                          } ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              visible3 == false
                  ? Visibility(
                  visible: true,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("778978988"),
                          Text(""),
                          Text("sky@mail.com"),
                        ]
                    ),
                  ))
                  : Container(),
            ],
          ),


      ]));

  }


}
