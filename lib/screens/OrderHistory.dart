import 'package:flutter/material.dart';
import 'package:skystacos_app/Utils/ListUtils.dart';
import 'package:skystacos_app/screens/FeedBackScreen.dart';
import 'package:skystacos_app/screens/HomeScreen.dart';

class OrderHistory extends StatefulWidget {
  final double rating;
  final String nameOfProduct;
  final String priceOfProduct;
  final String imageOfProduct;
  final String lengthOfProduct;
  OrderHistory(
      {this.rating,
        this.imageOfProduct,
        this.priceOfProduct,
        this.nameOfProduct,
        this.lengthOfProduct});
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "Order History",
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
      backgroundColor: Color(0xffF3F3F3),
      body: ListView(
        children: [
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
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
                height: 135,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Color(0xffeae8e6),
                ),
                child: Row(children: [
                  Container(
                    height: 115,
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
                    padding: const EdgeInsets.only(top: 8.0, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ListUtils.listOfcart[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5.0,
                        ),
                        //SizedBox(height: 10.0,),
                        Container(
                          width: 210,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(ListUtils.listOftitle[index],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Container(
                          width: 210,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(ListUtils.listOfProductPrice[index],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        builButton(onTap2: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                        },
                            onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FeedBackScreen(
                                imageOfProduct: ListUtils.listOfCartImages[index],
                                nameOfProduct: ListUtils.listOfcart[index],
                                rating: ListUtils.shortRating[index].toDouble(),
                                priceOfProduct: ListUtils.listOfcartPrice[index],
                              )));
                        }),
                      ],
                    ),
                  ),
                ])));
      },
    );
  }

  Widget builButton({onTap,onTap2}) {
    return Container(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
        height: 30,
        width: 90,
        child: RaisedButton(
          textColor: Colors.white,
          color: Color(0xff61CE70),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          onPressed: onTap2,
          child: Text(
            "ReOrder",
            style: TextStyle(
                fontStyle: FontStyle.normal, fontSize: 13),
          ),
        ),
      ),
          Container(
            height: 30,
            width: 90,
            child: RaisedButton(
              textColor: Colors.black,
              color: Color(0xffD1D1D1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              onPressed: onTap,
              child: Text(
                "Feedback",
                style: TextStyle(fontStyle: FontStyle.normal, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
