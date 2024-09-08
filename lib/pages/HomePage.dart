import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_it_bro/Widgets/showDeleteNoteDialog.dart';
import 'AddNotePage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final uid = FirebaseAuth.instance.currentUser!.uid;

  // Function to format timestamp based on the conditions provided
  String formatTimestamp(Timestamp timestamp) {
    DateTime noteDate = timestamp.toDate();
    DateTime now = DateTime.now();

    // Calculate the time difference
    Duration difference = now.difference(noteDate);

    if (difference.inDays == 0) {
      // If the note was edited today
      return "Today ${DateFormat.Hm().format(noteDate)}";
    } else if (difference.inDays == 1) {
      // If the note was edited yesterday
      return "Yesterday ${DateFormat.Hm().format(noteDate)}";
    } else {
      // For all other days, show the full date
      return DateFormat('dd/MMM/yyyy HH:mm').format(noteDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Notes', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
        actions: [
          Text(
              "Logout",
              style: TextStyle(color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst); // Log out and return to login page
            },
            icon: const Icon(Icons.logout),
            color: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection(uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Error fetching data"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No data"));
            }

            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var document = documents[index];
                Timestamp lastEditTimestamp = document['time']; // Fetch the 'time' field
                String lastEditTime = formatTimestamp(lastEditTimestamp); // Format the timestamp

                return GestureDetector(
                  onTap: () {
                    // Passed the noteId to AddNotePage when an existing note is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNotePage(
                          noteId: document.id,
                        ),
                      ),
                    );
                  },
                  child: GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => showDeleteNoteDialog(context, document['title']),
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
                              document['title'].length > 14
                                  ? document['title'].substring(0, 14) + '...'
                                  : document['title'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Expanded(
                              child: Text(
                                document['content'].length > 75
                                    ? document['content'].substring(0,75) + '...'
                                    : document['content'],
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight, // Align the timestamp in the bottom right
                              child: Text(
                                lastEditTime,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          // Open AddNotePage without noteId (for adding a new note)
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const AddNotePage(noteId: null,)));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
