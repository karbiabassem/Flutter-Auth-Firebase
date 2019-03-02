import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
        ),
        body: Container(
          child: Center(
            child: Text("welcome"),
          ),
        ));
  }
}
