import 'package:flutter/material.dart';
import 'package:skystacos_app/Utils/ListUtils.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';
class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "My Order",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.only(top:15.0,left: 10),
          child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen(
                            )));
                  },
                  child: Image.asset("assets/images/slider-icon.png",height: 33,))),
        ),
      ),
      backgroundColor: Color(0xffF3F3F3),
      body: ListView(
        children: [
          SizedBox(height: 10,),
          buildProductList(),
        ],
      ),
    );
  }

  buildProductList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: ListUtils.listOfCartImages.length,
      padding: EdgeInsets.all(10.0),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.only(bottom:20.0),
            child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xffeae8e6),

                ),
                child: Row(
                    children: [
                      Container(
                        height: 107,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                              image: AssetImage(
                                ListUtils.listOfCartImages[index],
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 180,
                                  child: Text(
                                      ListUtils.listOfcart[index],style: TextStyle(color: Colors.black,fontSize: 16,
                                      fontWeight: FontWeight.w500)
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Image.asset("assets/images/location.png",height: 34,color: Colors.blueAccent,))),
                              ],
                            ),
                            Container(
                              width: 210,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(ListUtils.listOftitle[index],style: TextStyle(color: Colors.grey,fontSize: 16,
                                      fontWeight: FontWeight.w300)),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.0,),
                            Container(
                              width: 210,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(ListUtils.listOfProductPrice[index],style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                      ],
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ]
                )
            )
        );
      },

    );
  }
}
