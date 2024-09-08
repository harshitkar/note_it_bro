import 'package:flutter/material.dart';
import 'package:note_it_bro/Auth/auth_service.dart';
import 'package:note_it_bro/pages/SignupPage.dart';  // Make sure to import SignupPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String id = '';
  String password = '';
  bool _obscurePassword = true; // State variable to manage password visibility

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
                          Image.network(
                            'https://static-00.iconduck.com/assets.00/note-taking-app-icon-2048x2048-mt93xtc5.png',
                            height: 200,
                            width: 200,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
                              label: Text("Email ID", style: TextStyle(color: Colors.white)),
                              labelStyle: TextStyle(color: Colors.white),
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
                                  !value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              id = value!;
                            },
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              label: const Text("Password", style: TextStyle(color: Colors.white)),
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty || value.length < 7) {
                                return 'Please enter a valid password';
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
                    child: const Text('Log In', style: TextStyle(color: Colors.cyan)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20), // Add space between buttons
                  OutlinedButton(
                    onPressed: () {
                      AuthService().signInWithGoogle(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.blue, width: 2), // Border color and width
                      backgroundColor: Colors.white, // Background color
                      minimumSize: Size(200, 50), // Ensure button wraps content
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40), // Decreased corner radius
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Wrap content
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://cdn4.iconfinder.com/data/icons/logos-brands-7/512/google_logo-google_icongoogle-1024.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 10),
                        const Text("Sign in with Google", style: TextStyle(color: Colors.cyan)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupPage()));
                    },
                    child: const Text("Don't have an account? Signup", style: TextStyle(color: Colors.white)),
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