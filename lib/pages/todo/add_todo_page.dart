import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  String task = "", description = "", dueDate = "";
  bool remindMe = false, important = false;

  void _changeTask(value) {
    setState(() {
      task = value;
    });
  }

  void _changeDescription(value) {
    setState(() {
      description = value;
    });
  }

  void _changeDueDate(value) {
    setState(() {
      dueDate = value;
    });
  }

  void _changeRemindMe(value) {
    setState(() {
      remindMe = value;
    });
  }

  void _changeImportant(value) {
    setState(() {
      important = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple[700],
        title: const Text(
          'Tambah todo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Nama todo',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      _changeTask(value);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Masukan nama todo',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2.0),
                        )),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Deskripsi',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      _changeDescription(value);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Masukan deskripsi todo',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2.0),
                        )),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Tenggat waktu',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    onChanged: (value) {
                      _changeDueDate(value);
                    },
                    decoration: const InputDecoration(
                        hintText: 'Masukan tenggat waktu',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2.0),
                        )),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Remind Me'),
              activeColor: Colors.deepPurple[600],
              contentPadding: const EdgeInsets.symmetric(horizontal: 6),
              dense: true,
              value: remindMe,
              onChanged: (bool? value) {
                _changeRemindMe(value);
              },
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Important'),
              activeColor: Colors.deepPurple[600],
              contentPadding: const EdgeInsets.symmetric(horizontal: 6),
              dense: true,
              value: important,
              onChanged: (bool? value) {
                _changeImportant(value);
              },
            ),
            /**
             * START : List Task
             */

            /**
             * END : List Task
             */
            Container(
              padding: EdgeInsets.all(16.0),
              child: OutlinedButton(
                onPressed: () {},
                child: Text(
                  '+ Tambah task',
                  style: TextStyle(color: Colors.deepPurple),
                ),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                    side: BorderSide(width: 1.0, color: Colors.deepPurple)),
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.deepPurple,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                // loginToSystem();
                // simpleLogin();
              },
              child: const Text('Simpan'))),
    );
  }
}
