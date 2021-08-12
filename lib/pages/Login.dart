

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/Controller/google_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 90,),
              Image.network("https://previews.123rf.com/images/lenm/lenm0810/lenm081000140/3701740-note-taking.jpg"),
              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text("Create and Manage your Notes",
                style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () async => await{signInwithGoogle(context)},
                child: Container(
                  height: 40,
                  width: 40,
                  child: Image.network("https://image.flaticon.com/icons/png/512/2875/2875331.png")),
              )

            ],
          ),
        ),
      ),
    );
  }
}