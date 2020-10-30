import 'package:authorised_chat/Screens/chatRoomsScreen.dart';
import 'package:authorised_chat/helper/helperfunctions.dart';
import 'package:authorised_chat/services/auth.dart';
import 'package:authorised_chat/services/database.dart';
import 'package:authorised_chat/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  
  bool isLoading = false;

  AuthMethod authMethods = new AuthMethod();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();

  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUp(){
    if(formKey.currentState.validate()){
      Map<String , String> userInfoMap = {
        "name" : userNameTextEditingController.text,
        "email" : emailTextEditingController.text
      };

      HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);



      setState(() {
        isLoading = true;
      });

      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        //print("${val.uid}");



        databaseMethods.uploadUserInfo(userInfoMap);

        HelperFunctions.saveUserLoggedInSharedPreference(true);


        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ChatRoom()
        ));
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain("Sign Up"),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ):SingleChildScrollView(
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
                              return val.isEmpty || val.length < 4 ? "Please provide a valid username": null ;
                            },
                            controller: userNameTextEditingController,
                            style: simpleTextStyle(),
                            decoration: textFieldInputDecoration("username")
                        ),
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
                        //TODO
                        signMeUp();
                      },

                      child: Text(
                        'Sing Un',
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

                      onPressed: (){
                        //TODO
                      },

                      child: Text(
                        'Sing Un with google',
                        style: buttonStyle(),
                      ),



                    ),
                  ),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                        style: simpleTextStyle(),
                      ),
                      GestureDetector(
                        onTap: (){
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("Sign In now",
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
