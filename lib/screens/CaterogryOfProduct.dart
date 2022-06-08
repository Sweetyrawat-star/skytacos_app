import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skystacos_app/ApiHandler.dart';
import 'package:skystacos_app/models/getCategory.dart';
import 'package:skystacos_app/screens/Product-List.dart';


class CategoryOfProduct extends StatelessWidget {
  final String id;
  CategoryOfProduct({this.id});
  static var value;
  Future<GerCategoryModel> getProductCategory() async {
    try{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString("token");
      print("token" + "$token");
      final url =
      //"http://skytacos.ouctus-platform.com/skystacos/v1/category";
          "http://skytacos.ouctus-platform.com/skystacos/v1/category?locationId=$id";

      final response = await http.get(
        url,
      );
      print(response);
      if (response.statusCode == 200) {
        GerCategoryModel model=GerCategoryModel.fromJson(jsonDecode(response.body));
        var jsonPropertyVault = jsonDecode(response.body);
        print(response.statusCode);
        print(response.body);
        for(var i = 0; i< model.data.length; i++) {

          int value =model.data[i].categoryId;
          print(value);
          sharedPreferences.setInt("categoryId",value);
        }


        var token2 = sharedPreferences.getInt("categoryId");
        print(token2);
        return GerCategoryModel.fromJson(jsonPropertyVault);
      } else {
        throw Exception();
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        //color: Colors.red,
        child: FutureBuilder(
          future: getProductCategory(),
          builder:
              (BuildContext context, AsyncSnapshot<GerCategoryModel> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductList(
                                  customerId:
                                  snapshot.data.data[index].categoryId,
                                  categoryName: snapshot
                                      .data.data[index].categoryName,
                                )));
                      },
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                height: 107,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                      image:
                                      snapshot.data.data[index].catImage ==
                                          null
                                          ? AssetImage("assets/food1.jpg")
                                          : NetworkImage(
                                        ApiHandler.url +
                                            snapshot.data.data[index]
                                                .catImage,
                                      ),
                                      fit: BoxFit.fill),
                                ),
                              )),
                          SizedBox(
                            height: 2.0,
                          ),
                          SizedBox(
                            height: 2.0,
                          ),
                          snapshot.data.data[index].categoryName == null
                              ? Text("Loading....")
                              : Container(
                            width: 200,
                            child: Text(
                              snapshot.data.data[index].categoryName,
                              softWrap: false,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
