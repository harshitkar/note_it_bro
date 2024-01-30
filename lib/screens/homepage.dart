import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
          Text(
            "data is here",
            style: TextStyle(
                fontSize: 50,
                color: Colors.deepPurple
            ),
          ),
      ),
    );
  }
}