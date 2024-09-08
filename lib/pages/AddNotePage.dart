import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  final String? noteId;

  const AddNotePage({this.noteId, super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.noteId != null) {
      _fetchNoteData();
    } else {
      _isLoading = false;
    }
  }

  Future<void> _fetchNoteData() async {
    try {
      DocumentSnapshot document = await FirebaseFirestore.instance
          .collection(uid)
          .doc(widget.noteId)
          .get();

      if (document.exists) {
        setState(() {
          _titleController.text = document['title'] ?? '';
          _contentController.text = document['content'] ?? '';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching document: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          widget.noteId != null ? 'Edit Note' : 'Create Note',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                if (widget.noteId != null) {
                  if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection(uid)
                        .doc(widget.noteId)
                        .update({
                      'title': _titleController.text,
                      'content': _contentController.text,
                      'time': DateTime.now(),
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection(uid)
                        .doc(widget.noteId)
                        .delete();
                  }
                } else if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty) {
                  await FirebaseFirestore.instance.collection(uid).add({
                    'title': _titleController.text,
                    'content': _contentController.text,
                    'time': DateTime.now(),
                  });
                }

                if (context.mounted) {
                  Navigator.of(context).pop(); // Go back to HomePage
                }
              }
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                maxLines: null,  // Allow the text to wrap
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                validator: (value) => value?.isEmpty == true ? 'Title cannot be empty' : null,
              ),
              const SizedBox(height: 8.0), // Add spacing between fields
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Content',
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                validator: (value) => value?.isEmpty == true ? 'Content cannot be empty' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
