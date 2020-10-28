import 'package:flutter/material.dart';

Widget appBarMain (String textAppBar){
  return AppBar(
    backgroundColor: Colors.blue,
    title: Text(
      '$textAppBar',
      style: TextStyle(
        fontSize: 15.0,
        color: Colors.grey[300],

      ),
    ),

  );
}

InputDecoration textFieldInputDecoration(String hinttext){

  return InputDecoration(
    hintText: hinttext,
    hintStyle: TextStyle(
      color: Colors.black12,

    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black)
    ),
  );

}

TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.grey[900],
    fontSize: 16,
  );
}

TextStyle buttonStyle(){
  return TextStyle(
      color: Colors.white,
     fontSize: 18.0
  );
}