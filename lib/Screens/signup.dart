import 'package:authorised_chat/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain("Sign Up"),
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
                  TextField(
                    controller: userNameTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("username")
                  ),
                  TextField(
                    controller: emailTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("email")
                  ),
                  TextField(
                    controller: passwordTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration("password")
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

                      onPressed: (){},

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

                      onPressed: (){},

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
                      Text("Sign In now",
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        )

                        ,
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
