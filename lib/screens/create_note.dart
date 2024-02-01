import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final auth=FirebaseAuth.instance.currentUser!.email;

  final _formKey = GlobalKey<FormState>();

  String title = '';

  String content = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Create Note',
          style: TextStyle(color: Colors.white)
        ),
        actions: [
          IconButton(
            onPressed: ()async {
              _formKey.currentState!.validate();
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              await FirebaseFirestore.instance.collection(auth!).add({
                'title': title,
                'content': content,
                'time':DateTime.now(),
              });
              if(context.mounted){
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some valid email';
                  }
                  return null;
                },
                onSaved: (value){
                  title=value!;
                },
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Content',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some valid email';
                    }
                    return null;
                  },
                  onSaved: (value){
                    content=value!;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}