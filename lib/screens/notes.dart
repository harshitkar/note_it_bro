import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_it_bro/Auth/auth_service.dart';
import 'package:note_it_bro/Widgets/show_dialog.dart';
import 'create_note.dart';

class Notes extends StatelessWidget {
  Notes({super.key});

  final auth = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Notes',style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(

            onPressed: () {
              AuthService().signOut(context);
            },
            icon: const Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(auth!).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ), itemCount: documents.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: (){
                          showDialog(context: context,
                            builder:(BuildContext context)=>showDialogQ(context,documents[index]['title']
                            )
                        );
                      },
                      child: Card(
                        color: Colors.cyan,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                documents[index]['title'],
                                style: const TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                  documents[index]['content'],
                                  style: const TextStyle(color: Colors.white)
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: Text("No data"));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateNote()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}