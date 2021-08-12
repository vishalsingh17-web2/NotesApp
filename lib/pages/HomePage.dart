import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/Controller/google_auth.dart';


import 'AddNote.dart';
import 'ViewNote.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref= FirebaseFirestore.instance
    .collection("users").doc(FirebaseAuth.instance.currentUser!.uid)
    .collection("notes");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red[50],
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(googleSignIn.currentUser!.photoUrl!)
              )
            ),
            ),
            title: Text("Your Notes", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

        ),
        backgroundColor: Colors.red[50],
        body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  String data = snapshot.data!.docs[index].get('title');
                  var date = snapshot.data!.docs[index].get('created').toDate();
                  String desc = snapshot.data!.docs[index].get('description');
                  return Card(
                    color: Colors.red[50],
                    elevation: 4,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>ViewNote(data,desc,date,snapshot.data!.docs[index].reference))
                        ).then((value){
                          setState(() {
                            
                          });
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(20)
                        ),
                        margin: EdgeInsets.all(6),
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Icon(Icons.arrow_right),
                                Container(
                                  margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Text(data.toString(),style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      fontFamily: GoogleFonts.wellfleet().fontFamily),),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(DateFormat.yMMMEd().add_jm().format(date),style: TextStyle(fontWeight: FontWeight.w500),),), 
                          ],
                        ),
                      ),
                    ),
                  );
                });
            }
            else{
              return CircularProgressIndicator();
            }
          },
        ),
        floatingActionButton: IconButton(
          highlightColor: Colors.red[700],
          alignment: Alignment.topLeft,
          color: Colors.black,
          icon: Icon(Icons.add,size: 40,),
          onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context)=>AddNote())
            ).then((value){
              setState(() {
                
              });
            });
          },
        ),
      ),
    );
    
  }
}