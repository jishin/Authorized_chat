import 'package:firebase_auth/firebase_auth.dart';
import 'package:authorised_chat/modal/user.dart';

class AuthMethod{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  IUser _userFromFirebaseUser(User user){
    return user != null ? IUser(userId: user.uid): null;
  }

  Future signInWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser= result.user;
      return _userFromFirebaseUser(firebaseUser);
      //return result;


    }catch(e){
      print(e);
      print("hello ji");
    }
  }

  Future signUpWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser= result.user;
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