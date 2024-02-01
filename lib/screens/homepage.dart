import 'package:flutter/material.dart';
import 'package:note_it_bro/Auth/auth_service.dart';
import 'package:note_it_bro/screens/sign_up.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  String id = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.lightBlue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 200,
                            color: Colors.white,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.cyan,
                            decoration:const InputDecoration(
                              label: Text("ID",style: TextStyle(color: Colors.white),),
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter some valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              id = value!;
                            },
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.cyan,
                            decoration: const InputDecoration(
                              label: Text("Password",style: TextStyle(color: Colors.white),),
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 7) {
                                return 'Please enter some valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password = value!;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      AuthService().signInWithEmail(id, password);
                    },
                    child: const Text('submit',style: TextStyle(color: Colors.cyan),),
                  ),
                  IconButton(
                    onPressed: () {
                      AuthService().signInWithGoogle(context);
                    },
                    icon: const Icon(Icons.login),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
                    },
                    child: const Text("Create user",style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}