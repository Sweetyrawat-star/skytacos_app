import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/models/LocationModel.dart';
import 'package:skystacos_app/models/bannerModel.dart';
import 'package:skystacos_app/models/bestsellermodel.dart';
import 'package:skystacos_app/models/getCategory.dart';
import 'package:skystacos_app/models/getprofileuser.dart';
import 'package:skystacos_app/screens/BestSeller.dart';
import 'package:skystacos_app/screens/CaterogryOfProduct.dart';
import 'package:skystacos_app/screens/Drawer.dart';
import 'package:skystacos_app/screens/Product-List.dart';
import 'package:skystacos_app/screens/ProductDetailScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/sharedpreference/store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String token;
  String restroLocation,restroName;
  bool _isLoading = false;
  String bannerImage, bannerHeading, bannerText;
  String name, userId, phoneNumber, email, imageUser,longitude,latitude;
  var id;

  var image;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  List locationList;
  String _myLocation,locationVal,restrorantName;
  var jsonPropertyVault;
  DateTime backbuttonpressedTime;
  ApiHandler handler = ApiHandler();
  LocationDropdownModel _dropdownModel = LocationDropdownModel();

  BestSellerModel model = BestSellerModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startFunction();


  }

  startFunction()async{
    _getCurrentLocation();
    getBanner();
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
        print(_currentAddress);
        print(_currentPosition.latitude);
        print(_currentPosition.longitude);
      });
    } catch (e) {
      print(e);
    }
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
      getLocation();
    }).catchError((e) {
      print(e);
    });
  }



  Future<LocationDropdownModel> getLocation() async {
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString("token");
      print("token" + "$token");
      var lon= _currentPosition.longitude;
      var lati = _currentPosition.latitude;
      final url =
          "http://skytacos.ouctus-platform.com/skystacos/v1/location?longitude=${lon}&latitude=${lati}";
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token"
        },
      );
      print(response);

      if (response.statusCode == 200) {
        setState(() {
          jsonPropertyVault = jsonDecode(response.body);
          print(response.statusCode);
          print(response.body);
          _dropdownModel= LocationDropdownModel.fromJson(jsonPropertyVault);
          id = _dropdownModel.data[0].id.toString();
          restroName = _dropdownModel.data[0].restName.toString();
          _isLoading=true;
        });
        print("location: $id");
        // for(var i = 0; i< _dropdownModel.data.length; i++) {
        //   int value =_dropdownModel.data[i].id;
        //   print(value);
        //   sharedPreferences.setInt("id",value);}

        return LocationDropdownModel.fromJson(jsonPropertyVault);
      } else {
        throw Exception();
      }
    }catch(e){
      print(e);
    }
    return LocationDropdownModel();
  }

  Future<ProfileModel> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    final url = "http://skytacos.ouctus-platform.com/skystacos/v1/user";
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $store1"
    });
    print(response);
    if (response.statusCode == 200) {
      final jsonPropertyVault = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      userId = jsonPropertyVault["data"]["UserId"].toString();
      name = jsonPropertyVault["data"]["FirstName"].toString();
      email = jsonPropertyVault["data"]["emailAddress"].toString();
      imageUser = jsonPropertyVault["data"]["profileImage"].toString();
      phoneNumber = jsonPropertyVault["data"]["phoneNumber"].toString();
      //print("banner Heading $image");
      return ProfileModel.fromJson(jsonPropertyVault);
    } else {
      throw Exception();
    }
  }

  Future<BannerGetImageModel> getBanner() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    print("token" + "$token");
    final url = "http://skytacos.ouctus-platform.com/skystacos/v1/banner";
    final response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print('Token : ${token}');
    print(response);
    if (response.statusCode == 200) {
      final jsonPropertyVault = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      setState(() {
        bannerHeading = jsonPropertyVault["data"]["bannerHeading"].toString();
        print("banner Heading $bannerHeading");
        bannerImage = jsonPropertyVault["data"]["bannerImage"].toString();
        print("bannerImage $bannerImage");
        bannerText = jsonPropertyVault["data"]["bannerText"].toString();
        print("banner Text $bannerText");
      });

      return BannerGetImageModel.fromJson(jsonPropertyVault);
    } else {
      throw Exception();
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      appBar: AppBar(
        backgroundColor: ColorUtils.appColor,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DrawerUtil(
                      image: imageUser,
                      phoneNumber: phoneNumber,
                      email: email,
                      name: name,
                    )));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child:  _isLoading? ListView(
          children: [
            Stack(

              children: [
                Container(

                  padding: EdgeInsets.only(
                    left: 25.0,right: 15.0, ),

                  child:DropdownButton<String>(
                    value:  restroLocation,
                    hint:  restroName.toString()!=null?Text( restroName.toString() ):
                    Text("set your location"),
                    onChanged: (String newvalue) {
                      setState(() {
                        restroLocation = newvalue;
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));



                      });
                    },
                    items:  _dropdownModel.data?.map((item) {
                      restroLocation = item.id.toString();
                      return new  DropdownMenuItem(
                        child: new Text(item.restName),
                        value: item.id.toString(),
                      );
                    })?.toList() ??
                        [],
                    icon: Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                    isExpanded: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0, left: 5.0),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                ),
              ],
            ),

            bannerImage != null
                ? Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: bannerImage == null
                      ? AssetImage(
                    "assets/food1.jpg",
                  )
                      : NetworkImage(
                    ApiHandler.url + bannerImage.toString(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Container(
                  height: 140,
                  width: 140,
                  padding: const EdgeInsets.all(15.0),
                  color: Colors.transparent.withOpacity(0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      bannerHeading == null
                          ? Text("")
                          : Text(
                        bannerHeading.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      bannerText == null
                          ? Text("")
                          : Text(
                        bannerText.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            )
                : Container(),
            BestSeller(id:id),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            CategoryOfProduct(id: id)
          ],
        ):Center(child: CircularProgressIndicator(),),
      ),
    );
  }



  buildDropdown(){

    _isLoading? Stack(

      children: [
        Container(

          padding: EdgeInsets.only(
            left: 25.0,right: 15.0, ),

          child:DropdownButton<String>(
            value:  restroLocation,
            hint:  restroName.toString()!=null?Text( restroName.toString() ):
            Text("set your location"),
            onChanged: (String newvalue) {
              setState(() {
                restroLocation = newvalue;
                Navigator.push(context, MaterialPageRoute(builder: (context)=> BestSeller(id: restroLocation,)));
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryOfProduct(id: restroLocation)));
              });
            },
            items:  _dropdownModel.data?.map((item) {
              restroLocation = item.id.toString();
              return new  DropdownMenuItem(
                child: new Text(item.restName),
                value: item.id.toString(),
              );
            })?.toList() ??
                [],
            icon: Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
            isExpanded: true,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15.0, left: 5.0),
          child: Icon( 
            Icons.location_on,
            color: Colors.grey,
            size: 20.0,
          ),
        ),
      ],
    ):Center(child: CircularProgressIndicator(),);
    // return FutureBuilder(
    //   future: getLocation(),
    //   builder: (BuildContext context, AsyncSnapshot<LocationDropdownModel> snapshot) {

    //     if(snapshot.data!=null){


    //       return
    //     }else{
    //       return Center(child: CircularProgressIndicator(),);
    //     }

    //   },
    // );



  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    //Statement 1 Or statement2

    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);
    if (backButton) {
      backbuttonpressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Double Click to exit app",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    return true;
  }
}