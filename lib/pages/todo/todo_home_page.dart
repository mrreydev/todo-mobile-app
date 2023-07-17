import 'package:flutter/material.dart';
import 'package:new_todo_app/base_widget/card_todo.dart';

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  String inputSearch = "";

  void _changeInputSearch(value) {
    setState(() {
      inputSearch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => {_changeInputSearch(value)},
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: 'Ketik judul untuk mencari todo.',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.deepPurple, width: 2.0),
                    )),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
              child: Column(
                children: <Widget>[
                  for (int x = 1; x <= 10; x++) ...[CardTodo()],
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
