
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';
import 'package:skystacos_app/sharedpreference/store.dart';

class EditProfileUserScreen extends StatefulWidget {
  final String name;
  final String phoneNumber;
  final String email;
  final int id;
  final String profileImage;
  EditProfileUserScreen(
      {this.name, this.id, this.email, this.phoneNumber, this.profileImage});
  @override
  _EditProfileUserScreenState createState() => _EditProfileUserScreenState();
}

class _EditProfileUserScreenState extends State<EditProfileUserScreen> {
  String name, userId, phoneNumber, email;
  bool circular = false;
  bool isDataLoaded = false;
  PickedFile _pickedFile;
  final ImagePicker imagePicker = ImagePicker();
  ProgressDialog pr;
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> key = new GlobalKey();
  final TextEditingController _controllerFullName = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();
  int id;
  List profiledata;
  String gallary;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userId = widget.id.toString();
      name= widget.name;
      _controllerEmail.text = widget.email;
      phoneNumber = widget.phoneNumber;
    });
  }

  var userid;
  void takePhoto(ImageSource source) async {
    final pickedFile = await imagePicker.getImage(source: source);
    setState(() {
      _pickedFile = pickedFile;
    });
  }
   _asyncFileUpload() async {
    setState(() {
      pr.show();
    });
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    store1 = sharedPreferences.getString("token");
    print("token" + "$store1");
    var header = "Bearer $store1";
    //create multipart request for POST or PATCH method
    final String url = "http://skytacos.ouctus-platform.com/skystacos/v1/user";
    var request = http.MultipartRequest("POST", Uri.parse(url));
    // var request = http.MultipartRequest
    Map<String, String> headers= {
      "Content-Type": "application/json",
      'Authorization': '$header',
    };
    request.headers.addAll(headers);
    request.fields['name'] = name.toString();
    request.fields['phoneNumber'] = phoneNumber.toString();
    var pic = await http.MultipartFile.fromPath("profileImage", _pickedFile.path);
    //add multipart to request
    request.files.add(pic);
    print(request);
    var response = await request.send();
    print(response);
    if(response.statusCode == 200 ){
      setState(() {
        pr.hide();
      });
      Fluttertoast.showToast(
          msg: "Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue[200],
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }


 

  bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "choose your profile photo",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                icon: Icon(Icons.camera),
                label: Text("Camera"),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
              ),
              FlatButton.icon(
                icon: Icon(Icons.photo),
                label: Text("Gallery"),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "Edit Profile",
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(top:20.0,right: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/images/close.png",height: 18,))),
          ),
          Padding(
            padding: const EdgeInsets.only(top:12.0,right: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    onTap: (){
                      final loginForm = key.currentState;
                        if (loginForm.validate()) {
                          loginForm.save();
                          _asyncFileUpload();
                        } else {
                          print("rrrrrrr");
                        }
                    },
                    child: Image.asset("assets/images/r.png",height: 33,width: 40,))),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Form(
            key: key,
                      child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffEFEFEF),
                    height: 200,
                    padding: EdgeInsets.all(30),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomSheet()));
                       
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                backgroundImage: _pickedFile == null
                                    ? NetworkImage(
                                       ApiHandler.url+widget.profileImage.toString(),
                                      )
                                    : FileImage(File(_pickedFile.path)),
                              ),
                              Positioned(
                                left: 65,
                                bottom:5,
                                child: GestureDetector(
                                    child:
                                         Icon(Icons.camera_alt,color: Colors.white,size: 35,)
                                    
                              ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            widget.name,
                            style: TextStyle(
                                color: ColorUtils.appColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            initialValue: widget.name,
                            onSaved: (val) => name = val,
                           
                            decoration: InputDecoration(
                              labelText: 'Name',
                              
                            ),
                          ),
                    
                          SizedBox(height: 20.0),
                          TextFormField(
                            initialValue: widget.phoneNumber,
                            onSaved: (val) => phoneNumber = val,
                           
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                            )
                          ),

                       
                          SizedBox(height: 20.0),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
