import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

String? title;
String? desc;

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: ()=> add(), icon: Icon(Icons.save),color: Colors.black,)
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_left),onPressed: (){
            Navigator.pop(context);
          },color: Colors.black,)
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(40, 60, 0, 10),
                child: Form(
                  child: TextFormField(
                    decoration: InputDecoration.collapsed(hintText: "Title"),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                        fontFamily: GoogleFonts.wellfleet().fontFamily),
                    onChanged: (_val){
                      title=_val;
                    },
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.7,
                width:MediaQuery.of(context).size.width*0.8,
                
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Form(
                  child: TextFormField(
                    maxLines: 50,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration.collapsed(hintText: "Description",),
                    onChanged: (_val){
                      desc=_val;
                    },
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: GoogleFonts.wellfleet().fontFamily),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void add(){
    CollectionReference ref= FirebaseFirestore.instance
    .collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("notes");

    var data= {
      "title":title,
      "description": desc,
      "created": DateTime.now()
    };
    ref.add(data);
    Navigator.of(context).pop();
  }
}
