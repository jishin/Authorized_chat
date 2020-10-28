import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User

  Future signInWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser fireBaseUser= result.user;


    }catch(e){

    }
  }

}