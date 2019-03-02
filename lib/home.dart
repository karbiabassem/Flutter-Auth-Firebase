import 'package:flutter/material.dart';
import './sign_up.dart';
import './sign_in.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            child: Text('SignUp'),
            color: Colors.redAccent,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
            },
          ),
          RaisedButton(
            child: Text('SignIn'),
            color: Colors.blueAccent,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
          )
        ],
      ),
    );
  }
}
