import 'package:flutter/material.dart';
import 'package:note_it_bro/Auth/auth_service.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final _formKey = GlobalKey<FormState>();
  String id = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration:const InputDecoration(
                              label: Text("ID"),
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
                            decoration: const InputDecoration(
                              label: Text("Password"),
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
                    onPressed: () async {
                      _formKey.currentState!.validate();
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      await AuthService().createUser(id, password);
                      Navigator.of(context).pop();
                    },
                    child: const Text('SignUp'),
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
