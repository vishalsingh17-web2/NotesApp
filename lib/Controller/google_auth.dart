
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notesapp/pages/HomePage.dart';


GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection("user");

Future<dynamic> signInwithGoogle(BuildContext context) async{
  try{
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if(googleSignIn!=null){
      GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
    final UserCredential authResult = await auth.signInWithCredential(credential);
    final User? user = authResult.user;
    var userData = {
      "name": googleSignInAccount.displayName,
      "provider":"google",
      "photoUrl":googleSignInAccount.photoUrl,
      "email":googleSignInAccount.email
    };
    users.doc(user!.uid).get().then((value) =>{
      if(value.exists){
        value.reference.update(userData)
      }
      else{
        users.doc(user.uid).set(userData)
      },
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=>HomePage())
      )
    } );
    }
  }catch(PlatformException){
    print(PlatformException);
    print("Sign In not Successful");
  }
  
}