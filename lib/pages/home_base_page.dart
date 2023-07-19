import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_todo_app/pages/profile_page.dart';
import 'package:new_todo_app/pages/todo/todo_home_page.dart';
import 'package:new_todo_app/pages/todo/todo_important_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBasePage extends StatefulWidget {
  const HomeBasePage({super.key});

  @override
  State<HomeBasePage> createState() => _HomeBasePageState();
}

class _HomeBasePageState extends State<HomeBasePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    TodoHomePage(),
    TodoImportantPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toAddTodoPage() {
    Navigator.pushNamed((context), '/add-todo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Important',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple[400],
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 2
          ? null
          : FloatingActionButton(
              onPressed: () {
                toAddTodoPage();
              },
              tooltip: 'Increment',
              backgroundColor: Colors.deepPurple[400],
              child: const Icon(Icons.add),
            ),
    );
  }
}
