import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import './welcome_page.dart';
import './sign_up.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String email = '';
  String password = '';
  //SignUp method
  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    //replace the key with your key
    final http.Response response = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=[your key]',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    var success = false;
    String message = 'Something went wrong';
    if (responseData.containsKey('idToken')) {
      success = true;
      message = 'Auth succeeded';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'please create an account to have access';
    }
    return {'succes': success, 'message': message};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIn'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: this._formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please enter an email';
                    }
                  },
                  onSaved: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'you@example.com', labelText: 'E-mail Address'),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please enter a password';
                    }
                  },
                  onSaved: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Password', labelText: 'Enter your Password'),
                ),
                Container(
                  child: Center(
                    child: RaisedButton(
                        child: Text('SignIn'),
                        color: Colors.blueAccent,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            print(email);
                            print(password);
                            print("signUp function");
                            final Map<String, dynamic> successInformation =
                                await signIn(email, password);
                            if (successInformation['succes']) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Great ;) ;)'),
                                      content: Text('you are on of us now'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Go'),
                                          color: Colors.greenAccent,
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WelcomePage()));
                                          },
                                        )
                                      ],
                                    );
                                  });
                            } else if (successInformation['message'] ==
                                'please create an account to have access') {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('An Eror Occured!'),
                                      content:
                                          Text(successInformation['message']),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Register'),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpPage()));
                                            ;
                                          },
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('An Eror Occured!'),
                                      content: Text(
                                          'Something wrong, you have to add all test ;) '),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }
                          } else {
                            print("eroor");
                          }
                        }),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
