import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ViewNote extends StatefulWidget {
  final String title;
  final String desc;
  final DateTime date;
  final DocumentReference ref;
  ViewNote(this.title, this.desc, this.date, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}
class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red[50],
        appBar: AppBar(
          title: Text("Details", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          actions: [
            IconButton(onPressed: ()=> delete(), icon: Icon(Icons.delete),color: Colors.red,)
          ],
          backgroundColor: Colors.red[50],
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_left),onPressed: (){
            Navigator.pop(context);
          },color: Colors.black,)
        ),
        body: SingleChildScrollView(
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height*0.83,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red.shade50
              ),
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                        fontFamily: GoogleFonts.wellfleet().fontFamily),),
                  Text("Created on:  "+DateFormat.yMMMEd().add_jm().format(widget.date),style: TextStyle(fontWeight: FontWeight.w500),),
                  SizedBox(height: 40,),
                  Text(widget.desc,style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: GoogleFonts.wellfleet().fontFamily),),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
  void delete() async {
    await widget.ref.delete();
    Navigator.of(context).pop();
  }
}
