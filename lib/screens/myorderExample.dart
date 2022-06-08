import 'package:flutter/material.dart';
import 'package:skystacos_app/Utils/ListUtils.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';
class MyOrderEx extends StatefulWidget {
  @override
  _MyOrderExState createState() => _MyOrderExState();
}

class _MyOrderExState extends State<MyOrderEx> {
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
                height: 220,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xffeae8e6),

                ),
                child: Column(
                  children: [
                    Container(
                      height: 30,
                      width: 360,
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey,),),
                      ),
                      child: Center(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  ListUtils.listOfcart[index],style: TextStyle(color: Colors.black,fontSize: 14,
                                  fontWeight: FontWeight.w500)
                              ),
                              SizedBox(height: 5,),
                              // Text("\$400",style: TextStyle(color: ColorUtils.redAppColor,fontSize: 12,
                              //     fontWeight: FontWeight.w500)),
                          Align(
                                                    alignment: Alignment.topRight,
                                                    child: GestureDetector(
                                                        onTap: (){
                                                          Navigator.pop(context);
                                                        },
                                                        child: Image.asset("assets/images/location.png",height: 34,color: Colors.blueAccent,))),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Ordered On: ",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                              SizedBox(width: 5,),
                              Text("24 jan 2020 at 9:10",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300)),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("Quantity: ",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                              SizedBox(width: 5,),
                              Text("1",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300)),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("Price: ",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                              SizedBox(width: 5,),
                              Text("\$500",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300)),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("Delivery Mode: ",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                              SizedBox(width: 5,),
                              Text("Self Pickup",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300)),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("Payment Mode: ",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                              SizedBox(width: 5,),
                              Text("PayPal",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300)),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("Ordered Id: ",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                              SizedBox(width: 5,),
                              Text("68768",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300)),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("Address: ",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                              SizedBox(width: 5,),
                              Text("mcf 150/b address nagar",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300)),
                            ],
                          ),

                          // SizedBox(height: 10,),
                          // Text("ORDERED ON",style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w500)),
                          // SizedBox(height: 5,),
                          // Text("24 jan 2020 at 9:10",style: TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 10,
                          //     fontWeight: FontWeight.w300)),

                        ],
                      ),
                    ),
                    // Align(
                    //     alignment: Alignment.bottomRight,
                    //     child: GestureDetector(
                    //         onTap: (){
                    //           Navigator.pop(context);
                    //         },
                    //         child: Container(
                    //           height: 30,
                    //           width: 90,
                    //           child: RaisedButton(
                    //             textColor: Colors.white,
                    //             color: Color(0xff61CE70),
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(5.0),
                    //             ),
                    //             onPressed: (){},
                    //             child: Text(
                    //               "ReOrder",
                    //               style: TextStyle(
                    //                   fontStyle: FontStyle.normal, fontSize: 13),
                    //             ),
                    //           ),
                    //         ),)),

                  ],
                ),
                // child: Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Container(
                //         height: 80,
                //         width: 100,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(5.0),
                //           image: DecorationImage(
                //               image: AssetImage(
                //                 ListUtils.listOfCartImages[index],
                //               ),
                //               fit: BoxFit.cover),
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 10),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Row(
                //               children: [
                //                 Container(
                //                   width: 180,
                //                   child: Text(
                //                       ListUtils.listOfcart[index],style: TextStyle(color: Colors.black,fontSize: 16,
                //                       fontWeight: FontWeight.w500)
                //                   ),
                //                 ),
                //                 Align(
                //                     alignment: Alignment.topRight,
                //                     child: GestureDetector(
                //                         onTap: (){
                //                           Navigator.pop(context);
                //                         },
                //                         child: Image.asset("assets/images/location.png",height: 34,color: Colors.blueAccent,))),
                //               ],
                //             ),
                //             Container(
                //               width: 210,
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Text(ListUtils.listOftitle[index],style: TextStyle(color: Colors.grey,fontSize: 16,
                //                       fontWeight: FontWeight.w300)),
                //                 ],
                //               ),
                //             ),
                //             SizedBox(height: 5.0,),
                //             Container(
                //               width: 210,
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Row(
                //                     children: [
                //                       Text(ListUtils.listOfProductPrice[index],style: TextStyle(
                //                           color: Colors.black,
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.w400)),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ),
                //
                //
                //           ],
                //         ),
                //       ),
                //     ]
                // )
            )
        );
      },

    );
  }
}
