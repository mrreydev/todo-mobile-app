import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_todo_app/view_model/user_view_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name = "", phone = "", email = "", password = "", confirmPassword = "";

  void _changeName(value) {
    setState(() {
      name = value;
    });
  }

  void _changePhone(value) {
    setState(() {
      phone = value;
    });
  }

  void _changeEmail(value) {
    setState(() {
      email = value;
    });
  }

  void _changePassword(value) {
    setState(() {
      password = value;
    });
  }

  void _changeConfirmPassword(value) {
    setState(() {
      confirmPassword = value;
    });
  }

  void toLogin() {
    Navigator.pushNamed((context), '/');
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

  void registerToSystem() async {
    if ((name == "") ||
        (phone == "") ||
        (email == "") ||
        (password == "") ||
        (confirmPassword == "")) {
      Fluttertoast.showToast(
          msg: "Form register tidak boleh kosong",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);

      return;
    }

    if (password != confirmPassword) {
      Fluttertoast.showToast(
          msg: "Konfirmasi password tidak sama.",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);

      return;
    }

    showLoaderDialog(context, 30);

    try {
      final resp = await UserViewModel()
          .register(name, phone, email, password, confirmPassword);

      print(resp);
      if (resp == null || resp == false) {
        Navigator.pop(context);

        Fluttertoast.showToast(
            msg: "Register gagal, silahkan coba kembali.",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red[800],
            textColor: Colors.white);

        return;
      }

      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Register Berhasil"),
              content: Text("Silahkan login untuk melanjutkan."),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              actions: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text("OK"),
                        style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Colors.green[400],
                            onSurface: Colors.grey),
                      ),
                    ))
              ],
            );
          });
    } catch (error) {
      Navigator.pop(context);

      print("error register $error");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Todo List',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Register untuk mulai mencatat todo.',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Nama',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) => {_changeName(value)},
                    decoration: const InputDecoration(
                        hintText: 'Masukan nama anda',
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
                      'Nomor Telepon',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) => {_changePhone(value)},
                    decoration: const InputDecoration(
                        hintText: 'Masukan nomor telepon anda',
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
                  const SizedBox(height: 24.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Konfirmasi Password',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) => {_changeConfirmPassword(value)},
                    decoration: const InputDecoration(
                        hintText: 'Masukan konfirmasi password anda',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.deepPurple, width: 2.0),
                        )),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      const Text('Sudah punya akun? '),
                      GestureDetector(
                        onTap: () {
                          toLogin();
                        },
                        child: const Text(
                          'Login disini.',
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: Colors.deepPurple,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {
                        registerToSystem();
                      },
                      child: const Text('Register')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
