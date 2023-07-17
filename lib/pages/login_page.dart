import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  bool? rememberMe = false;

  void _changeEmail(value) {
    this.setState(() {
      email = value;
    });
  }

  void _changePassword(value) {
    this.setState(() {
      password = value;
    });
  }

  void _changeRememberMe(value) {
    this.setState(() {
      rememberMe = value;
    });
  }

  void simpleLogin() {
    if (email == 'admin' && password == 'admin') {
      Navigator.pushNamed(context, '/menu');
    } else {
      Fluttertoast.showToast(
          msg: 'Username atau Password salah!',
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  void toRegister() {
    // Navigator.of(context).pop();
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/login.png',
                        ),
                        const Text(
                          'Todo List',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Masuk untuk melihat profile',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 24.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Email',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextField(
                          onChanged: (value) => {_changeEmail(value)},
                          decoration: const InputDecoration(
                              hintText: 'Masukan email anda',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepPurple, width: 2.0),
                              )),
                        ),
                        const SizedBox(height: 24.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Password',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextField(
                          onChanged: (value) => {_changePassword(value)},
                          decoration: const InputDecoration(
                              hintText: 'Masukan password anda',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepPurple, width: 2.0),
                              )),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                      ],
                    ),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Remember me'),
                    activeColor: Colors.deepPurple[600],
                    contentPadding: EdgeInsets.symmetric(horizontal: 6),
                    value: rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = value;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.deepPurple,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          // loginToSystem();
                          simpleLogin();
                        },
                        child: const Text('Login')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Belum punya akun? '),
                      GestureDetector(
                        onTap: () {
                          toRegister();
                        },
                        child: const Text(
                          'Register disini.',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      )
                    ],
                  )
                ]),
          )),
    );
  }
}
