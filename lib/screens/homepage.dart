import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: Colors.lightBlue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child:Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column (
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            'https://i.pinimg.com/originals/4b/d3/73/4bd373ce54d1d7c6d2f8a96bd04fff40.jpg',
                            height: 100,
                            width: 100,
                          ),
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(label: Text("Username",style: TextStyle(color: Colors.cyan),)),
                          cursorColor: Colors.cyanAccent[100],
                          validator: (value) {
                            if (value == null || value.isEmpty || !value.contains('@')) {
                              return 'Please enter some valid text';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(label: Text("Password",style: TextStyle(color: Colors.cyan),)),
                          cursorColor: Colors.cyanAccent[100],
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length < 7) {
                              return 'Please enter some valid text';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () { _formKey.currentState!.validate(); },
                              child: const Text("Submit"),
                              style: ElevatedButton.styleFrom(primary: Colors.blueAccent[100],onPrimary: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
