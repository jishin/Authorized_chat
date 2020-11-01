import 'package:authorised_chat/helper/constants.dart';
import 'package:authorised_chat/services/database.dart';
import 'package:flutter/material.dart';

import '../widget.dart';

class ConversationSacreen extends StatefulWidget {

  final String chatRoomId;
  ConversationSacreen(this.chatRoomId);

  @override
  _ConversationSacreenState createState() => _ConversationSacreenState();
}

class _ConversationSacreenState extends State<ConversationSacreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();
  Stream chatMessageStream;


  Widget ChatMessageList(){

    return StreamBuilder(
      stream : chatMessageStream,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageTile(snapshot.data.documents[index].data()["message"],

                  snapshot.data.documents[index].data()["sendBy"] == Constans.myName
              );
            }): Container();
      },
    );

  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> messageMap = {
      "message" :messageController.text,
      "sendBy" :Constans.myName,
      "time" : DateTime.now().microsecondsSinceEpoch,
    };
    databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
    messageController.text = "";
    }

  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain("ChatRoom"),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey[300],
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Message',
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

                          sendMessage();

                        },
                        icon: Icon(Icons.send),

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {

  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors : isSendByMe ? [
               Colors.blue[500],
               Colors.blue[300]
            ]
                : [
               Colors.grey[300],
               Colors.grey[500]
            ],
          ),
          borderRadius: isSendByMe?
              BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12)
              ):
              BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)
              )

        ),
        child: Text(
          message,
          style: TextStyle(
          color: Colors.grey[900],
          fontSize: 16,),
        )
      ),
    );
  }
}
