import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomWidget {

 static Widget buildLogoImageAndText({BuildContext context, double top,String text}){
    return Container(
      //color: Colors.red,
        padding: EdgeInsets.only(
          top: top,
        ),
        // height: 170,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",height: 140,fit: BoxFit.fitHeight,
            ),
            Text(text,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                )),
          ],
        ));
  }


  static Widget emailField({TextEditingController controller,BuildContext context,String email}) {
    return Theme(
      data: ThemeData(
        primaryColor: Color.fromRGBO(154, 197, 94,1),
        // primaryColorDark:Color.fromRGBO(238, 28, 37,1),
      ),
      child:  Container(
        // height: 150,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email",style: TextStyle(fontWeight: FontWeight.w500),),
            SizedBox(height: 10.0,),
            Theme(
              data: new ThemeData(
                primaryColor: Color(0xffC6C6C6),
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controller,
                onSaved: (val) => email = val,
                // initialValue: "abc",
                validator: (val) {
                  return val.length < 1 ? "Required" : null;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(
                        color: Colors.black
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xffC6C6C6),
                    ),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Color(0xffC6C6C6)),
                  // suffixIcon: Icon(Icons.mail,color: Colors.grey,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  static Widget appButton({BuildContext context, onTap,String text,double width,double height,double size}){
    return Container(
      //margin: EdgeInsets.only(top: 20),
      height: height,
      width: width,
      child: RaisedButton(
        textColor: Colors.white,
        color: Color(0xff61CE70),
        //padding: EdgeInsets.all(14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
              fontStyle: FontStyle.normal, fontSize: size),
        ),
      ),
    );
  }



  static Widget getBlueBtn({BuildContext context, String text, onTap}) {
    return Container(
      height: MediaQuery.of(context).size.height/13,
      width: MediaQuery.of(context).size.width-40,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.blue,
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
 static  Widget getTextFormField({
   BuildContext context,
    TextEditingController controller,
    String labelText,
    String hintText,
    String errorText,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    bool isPass = false,
    Icon icon,
    Color color,
    TextInputType keyboardType: TextInputType.text,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height-590,
      width: MediaQuery.of(context).size.width-10,
      //padding: EdgeInsets.only(left: 10, right: 10.0),
      child: TextField(
        controller: controller,
        onSubmitted: onSaved,
        obscureText: isPass,
        onChanged: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            suffixIcon: icon,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            // suffixText: "*",
            errorText: errorText,
            /*errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: ColorUtils.redColor)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: ColorUtils.greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: ColorUtils.greyColor),
            )*/),
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }




}
