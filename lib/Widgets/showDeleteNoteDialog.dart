import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_it_bro/Widgets/showSnackBar.dart';

Widget showDeleteNoteDialog(BuildContext context, String title) {
  return AlertDialog(
    title: const Text("Delete Note"),
    content: const Text("Do you want to delete this note?"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("No"),
      ),
      TextButton(
        onPressed: () async {
          FirebaseAuth auth = FirebaseAuth.instance;
          final userId = auth.currentUser!.uid;
          try {
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                .collection(userId)
                .where("title", isEqualTo: title)
                .get();

            for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
              await documentSnapshot.reference.delete();
              print('Document with title $title successfully deleted!');
            }
          } catch (e) {
            print('Document with title $title not successfully deleted!');
          }
          Navigator.pop(context);
        },
        child: const Text("Yes"),
      ),
    ],
  );
}
