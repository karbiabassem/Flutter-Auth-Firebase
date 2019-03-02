import 'package:flutter/material.dart';
import './welcome_page.dart';

class RedirectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Go To Welcome'),
          color: Colors.greenAccent,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WelcomePage()));
          },
        ),
      ),
    );
  }
}
