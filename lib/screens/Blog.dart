import 'dart:convert';
import 'package:better_player/better_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/models/blogModel.dart';
import 'package:video_player/video_player.dart';

class Blog extends StatefulWidget {
  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  bool visible = true;
  bool open = true;
  bool containerVisible = false;
  VideoPlayerController _controller;
  BetterPlayerController controller;

  @override
  void initState() {
    super.initState();
    getRankData();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "http://skytacos.ouctus-platform.com/public/admin/images/blogs/578868001607781747.mp4"
    );
    controller = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }


  void onVisible() {
    setState(() {
      visible = !visible;
    });
  }

  String token;
  bool _isLoading = false;
  String name, userId, phoneNumber, email, image;
  int id;
  Future<BlogModel> getRankData() async {
    final url = "http://skytacos.ouctus-platform.com/skystacos/v1/getblog";
    final response = await http.get(
      url, /*headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    }*/
    );
    print('Token : ${token}');
    print(response);
    if (response.statusCode == 200) {
      final jsonPropertyVault = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      userId = jsonPropertyVault["data"]["blogId"].toString();
      print("id $userId");
      name = jsonPropertyVault["data"]["blogTitle"].toString();
      print("name $name");
      email = jsonPropertyVault["data"]["blogContent"].toString();
      print(" email $email");
      phoneNumber = jsonPropertyVault["data"]["blogImage"].toString();
      print(" number$phoneNumber");
      image = jsonPropertyVault["data"]["blogVideo"].toString();

      return BlogModel.fromJson(jsonPropertyVault);
    } else {
      throw Exception();
    }
  }

  void containerMyVisible() {
    setState(() {
      containerVisible = !containerVisible;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff61CE70),
          title: Text(
            "Blog",
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
        backgroundColor: Color(0xffEFEFEF),
        body: FutureBuilder(
            future: getRankData(),
            builder: (BuildContext context, AsyncSnapshot<BlogModel> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "http://skytacos.ouctus-platform.com/"+snapshot.data.data.blogImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10),
                      child: Text(
                        snapshot.data.data.blogTitle,
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        snapshot.data.data.blogContent,
                        style: TextStyle(
                            color: ColorUtils.lightBlue, letterSpacing: 0.7,),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 230, top: 10, bottom: 10),
                          child: Container( 
                            
                            height: 40,
                            width: 120,
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.black54,
                              
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  onVisible();
                                  containerMyVisible();
                                });
                              },
                              child: Text(
                                "Read more",
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        visible == false
                            ? Visibility(
                                visible: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "In Marina del Rey, Sky’s Gourmet Marketplace serves high-quality grab-and-go foods "
                                    "(including our famous tacos), Groceries, has a full Deli counter and Delivers, even to"
                                    " the boat slips! At Sky’s Gourmet Tacos on Pico, our flagship enterprise, we serve over a thousand"
                                    " Tacos a month as well as many of our other popular items like specialty Vegan and Vegetarian dishes."
                                    "Sky’s Gourmet Catering provides turn-key solutions for any event or party with many options "
                                    "3for any size gathering from 50 to 10,000.",
                                    style: TextStyle(
                                        color: ColorUtils.lightBlue,
                                        letterSpacing: 0.7),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Container(
                      height: 200,
                      child: BetterPlayer(
                        controller: controller,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "In Marina del Rey, Sky’s Gourmet Marketplace serves high-quality grab-and-go foods "
                        "(including our famous tacos), Groceries, has a full Deli counter and Delivers, even to"
                        " the boat slips! At Sky’s Gourmet Tacos on Pico, our flagship enterprise, we serve over a thousand"
                        " Tacos a month as well as many of our other popular items like specialty Vegan and Vegetarian dishes."
                        "Sky’s Gourmet Catering provides turn-key solutions for any event or party with many options "
                        "3for any size gathering from 50 to 10,000.",
                        style: TextStyle(
                            color: ColorUtils.lightBlue, letterSpacing: 0.7),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}


