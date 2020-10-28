import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
            'Sign-In',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.grey[300],
            
          ),
        ),

      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 15),
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
