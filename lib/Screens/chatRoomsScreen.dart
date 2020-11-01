
import 'package:authorised_chat/Screens/conversation_screeen.dart';
import 'package:authorised_chat/Screens/search.dart';
import 'package:authorised_chat/helper/authenticate.dart';
import 'package:authorised_chat/helper/constants.dart';
import 'package:authorised_chat/helper/helperfunctions.dart';
import 'package:authorised_chat/services/database.dart';
import 'package:flutter/material.dart';
import 'package:authorised_chat/services/auth.dart';

import '../widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethod authMethods = new AuthMethod();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatRoomsStream;


  Widget chatRoomList(){
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (context, snapshot){
          return snapshot.hasData? ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return ChatRoomsTile(snapshot.data.documents[index].data()["chatroomId"]
                .toString().replaceAll("_", "").replaceAll("${Constans.myName}", ""),
                    snapshot.data.documents[index].data()["chatroomId"]);
              }): Container();
        },);
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async{

    Constans.myName = await HelperFunctions.getUserNameSharedPreference();
    databaseMethods.getChatRooms(Constans.myName).then((val){
      setState(() {
        chatRoomsStream = val;
      });

    });
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
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
        },
      ),
    );
  }
}


class ChatRoomsTile extends StatelessWidget {

  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> ConversationSacreen(chatRoomId)
        ));
      },
      child: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${userName.substring(0,1).toUpperCase()}",
                  style: simpleTextStyle()),
            ),
              SizedBox(width: 8,),
            Text(
                userName,
              style: simpleTextStyle(),
            ),

          ],
        ),
      ),
    );
  }
}
