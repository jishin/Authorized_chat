import 'package:authorised_chat/helper/helperfunctions.dart';
import 'package:authorised_chat/services/auth.dart';
import 'package:authorised_chat/services/database.dart';
import 'package:authorised_chat/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chatRoomsScreen.dart';

class SignIn extends StatefulWidget {

  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();

  AuthMethod authMethods = new AuthMethod();

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();


  QuerySnapshot snapshotUserInfo;
  bool isLoading = false;




  signIn(){
    if(formKey.currentState.validate()){


      //HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);

      databaseMethods.getUserByUserEmail(emailTextEditingController.text).then((val){
        snapshotUserInfo=val;
        HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.documents[0].data()["name"]);
      });

      //TODO function to get userDeatails
      setState(() {
        isLoading = true;
      });



      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text ).then((val){
        if(val != null) {


          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }
      });
    }
  }












 /* signIn() async {
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });

      //HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);




      //TODO function to get userDeatails




      await authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text ).then((val) async{
        if(val != null) {

          QuerySnapshot snapshotUserInfo = databaseMethods.getUserByUserEmail(emailTextEditingController.text);




          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.documents[0].data()["name"]);
          HelperFunctions.saveUserEmailSharedPreference(snapshotUserInfo.documents[0].data()["email"]);
          //HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);

          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));
        }else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }
  }

  */

























  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain("Sign In"),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 150, 10, 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                            validator: (val){
                              return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                              null : "Please provide a valid email";
                            },
                            controller: emailTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("email")
                        ),
                        TextFormField(
                            obscureText: true,
                            validator: (val){
                              return val.length > 6 ? null : "Please provide a valid password of 6 plus char";
                            },
                            controller: passwordTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("password")
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Text(
                        'Forgot Password?',
                        style: simpleTextStyle(),
                      ),
                    ),

                  ),
                  SizedBox(height: 10.0,),

                  Container(

                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        color: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),

                        onPressed: (){
                          signIn();
                        },

                        child: Text(
                          'Sing In',
                          style: buttonStyle(),
                        ),



                      ),
                    ),
                  SizedBox(height: 10,),
                  Container(

                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      color: Colors.grey[400],
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),

                      onPressed: (){},

                      child: Text(
                        'Sing In with google',
                        style: buttonStyle(),
                      ),



                    ),
                  ),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                        style: simpleTextStyle(),
                      ),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("Register now",
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            )

                            ,
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 60,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
