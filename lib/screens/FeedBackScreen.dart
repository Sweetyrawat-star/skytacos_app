import 'package:flutter/material.dart';
import 'package:skystacos_app/Utils/color_utils.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FeedBackScreen extends StatefulWidget {
  final double rating;
  final String nameOfProduct;
  final String priceOfProduct;
  final String imageOfProduct;
  final String lengthOfProduct;
  FeedBackScreen(
      {this.rating,
        this.imageOfProduct,
        this.priceOfProduct,
        this.nameOfProduct,
        this.lengthOfProduct});

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  TextEditingController messageEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff61CE70),
        title: Text(
          "Feedback",
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
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
                            widget.imageOfProduct,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.nameOfProduct,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          height: 5.0,
                        ),
                        //SizedBox(height: 10.0,),
                        SmoothStarRating(
                          rating: widget.rating,
                          color: Colors.orange,
                          borderColor: Colors.orange,
                          size: 15,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          defaultIconData: Icons.star_border,
                          starCount: 5,
                          allowHalfRating: false,
                          spacing: 2.0,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: [
                            Text(widget.priceOfProduct,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ])),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.only(left:15,right: 10),
            child: Row(
              children: [
                buildContainer(text: "5",rating: 5.0,color: Color(0xff3AB34A)),
                buildContainer(text: "4",rating: 4.0,color: Color(0xffBED73D)),
                buildContainer(text: "3",rating: 3.0,color: Color(0xffFDF100)),
                buildContainer(text: "2",rating: 2.0,color: Color(0xffF99F27)),
                buildContainer(text: "1",rating: 1.0,color: Color(0xffEC1D28)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 14, top: 10),
              color: Colors.white,
              //color: Color(0x54FFFFFF),
              child: TextField(
                controller: messageEditingController,
                style: TextStyle(color: Colors.black, fontSize: 16),
                decoration: InputDecoration(
                    hintText: "Comment",
                    hintStyle: TextStyle(
                      color: ColorUtils.lightBlue,
                      fontSize: 16,
                    ),
                    border: InputBorder.none
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:90.0,right: 90,top: 20),
            child: Container(
              height: 40,
              width: 150,
              child: RaisedButton(
                textColor: Colors.white,
                color: Color(0xff61CE70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: (){},
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontStyle: FontStyle.normal, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildContainer({String text,double rating,Color color}){
    return Container(
      height: 90.0,
        width: 66,
        color: color,
        padding: EdgeInsets.only(top:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,style: TextStyle(color: Colors.white,fontSize: 14),),
            SizedBox(height: 5.0,),
            SmoothStarRating(
              rating: rating,
              color: Colors.white,
              borderColor: Colors.white,
              size: 10,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              starCount: 5,
              allowHalfRating: false,
              spacing: 2.0,
            ),
          ],
        )
    );
  }
}
