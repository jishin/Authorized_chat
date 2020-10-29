import 'package:firebase_auth/firebase_auth.dart';
import 'package:authorised_chat/modal/user.dart';
import 'package:flutter/cupertino.dart';

class AuthMethod{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  IUser _userFromFirebaseUser(FirebaseUser user){
    return user != null ? IUser(userId: user.uid): null;
  }

  Future signInWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser= result.user;
      return _userFromFirebaseUser(firebaseUser);

    }catch(e){
      print(e);
    }
  }

  Future signUpWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser= result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print(e);
    }

  }

  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }


  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

}