
import 'package:authorised_chat/Screens/search.dart';
import 'package:authorised_chat/helper/authenticate.dart';
import 'package:authorised_chat/helper/constants.dart';
import 'package:authorised_chat/helper/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:authorised_chat/services/auth.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethod authMethods = new AuthMethod();

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{

    Constans.myName = await HelperFunctions.getUserNameSharedPreference();
    setState(() {
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ChatRoom',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,

          ),

        ),
        actions: [
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Icon(Icons.exit_to_app)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
        },
      ),
    );
  }
}
