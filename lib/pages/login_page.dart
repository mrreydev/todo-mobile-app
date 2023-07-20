import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_todo_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:new_todo_app/view_model/user_view_model.dart';
import 'package:new_todo_app/model/user_token_model.dart';

import 'package:new_todo_app/helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";

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

  showLoaderDialog(BuildContext context, int period) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading..."),
          )
        ],
      ),
    );

    late Timer _timer;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          _timer = Timer(Duration(seconds: period), () {
            Navigator.of(context).pop();
          });

          return alert;
        }).then(
      (value) {
        if (_timer.isActive) {
          _timer.cancel();
        }
      },
    );
  }

  void loginToSystem() async {
    if ((email == "") || (password == "")) {
      Fluttertoast.showToast(
          msg: "Email dan password tidak boleh kosong",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);

      return;
    }

    showLoaderDialog(context, 30);
    var respToken = null;

    try {
      respToken = await UserViewModel().login(email, password);
    } catch (error) {
      Navigator.pop(context);
      print("error login $error");
      return;
    }

    if (respToken == null) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Email atau password salah, mohon periksa kembali.",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);

      return;
    }

    saveToken(respToken);

    var respUser = null;

    try {
      respUser = await UserViewModel().loggedInUser();
    } catch (error) {
      Navigator.pop(context);
      print("error getLoggedIn $error");
    }

    if (respUser == null) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Login gagal, harap coba kembali.",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);

      return;
    }

    Navigator.pop(context);

    saveUser(respUser);

    Navigator.pushNamed((context), '/homepage');
  }

  void saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('token')) {
      pref.remove('token');
    }
    pref.setString('token', token);
  }

  void saveUser(UserModel user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('userInfo')) {
      pref.remove('userInfo');
    }

    pref.setString('userInfo', jsonEncode(user.toJson()));
  }

  void toRegister() {
    Navigator.pushNamed(context, '/register');
  }

  checkLoggedIn() async {
    var token = Helper().getToken();

    if (token != null) {
      try {
        final respUser = await UserViewModel().loggedInUser();

        if (respUser != null) {
          Navigator.of(context).pop();
          Navigator.pushNamed((context), '/homepage');
        }
      } catch (error) {
        print("error $error");
      }
    }

    FlutterNativeSplash.remove();
  }

  void initState() {
    super.initState();
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    checkLoggedIn();
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
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.deepPurple,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        onPressed: () {
                          loginToSystem();
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
