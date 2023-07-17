import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Todo List',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                      // loginToSystem();
                      // simpleLogin();
                    },
                    child: const Text('Register')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
