import 'package:authorised_chat/Screens/conversation_screeen.dart';
import 'package:authorised_chat/helper/constants.dart';
import 'package:authorised_chat/services/database.dart';
import 'package:authorised_chat/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;

  initiateSearch(){
    databaseMethods.getUserByUserName(searchTextEditingController.text).then((val){
      setState(() {

        searchSnapshot = val;
      });
    });
  }

  ///create chatroom, send user to converstion screen, pushreplacement




  Widget searchList(){
    return searchSnapshot != null ?  ListView.builder(
      itemCount: searchSnapshot.documents.length ,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return SearchTile(
            userName: searchSnapshot.documents[index].data()["name"],
            userEmail: searchSnapshot.documents[index].data()["email"],
          );


        }
    ): Container();
  }

  createChatroomAndStartConversation( String userName ){

    if(userName != Constans.myName) {
      String chatRoomId = getChatRoomId(userName, Constans.myName);

      List<String> users = [userName, Constans.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
        //"chatoomId": chatRoomId
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationSacreen(
            chatRoomId
          )
      ));
    }else{
      print("you cannot send yourself messages");
    }

  }

  Widget SearchTile({String userName, String userEmail}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: simpleTextStyle(),),
              Text(userEmail,style:  simpleTextStyle(),),
            ],
          ),
          Spacer(),
          RaisedButton(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),

            onPressed: (){
              //TODO


              createChatroomAndStartConversation( userName);

            },

            child: Text(
              'Message',
              style: buttonStyle(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain('Search'),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchTextEditingController,
                        style: TextStyle(
                             color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'search username',
                           hintStyle: TextStyle(
                             color: Colors.black12,
                           ),
                          border: InputBorder.none,
                      ),
                     ),
                  ),

                  Container(

                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0x36FFFFFF),
                          const Color(0x0FFFFFFF)
                        ]
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),

                    child: IconButton(
                      onPressed: (){

                        initiateSearch();

                      },
                      icon: Icon(Icons.person_search_outlined),

                    ),
                  ),
                ],
              ),
            ),
            searchList()

          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
  //if (a.codeUnitAt(0) > b.codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
