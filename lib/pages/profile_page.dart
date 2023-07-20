import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_todo_app/helper.dart';
import 'package:new_todo_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:new_todo_app/base_widget/profile_menu_item.dart';
import 'package:new_todo_app/model/profile_menu_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? loggedInUser;

  List<ProfileMenuModel> listMenu = [
    ProfileMenuModel('Edit profile', '/', Colors.black87),
    ProfileMenuModel('Ganti password', '/', Colors.black87),
    ProfileMenuModel('Logout', '/', Colors.red)
  ];

  void handleTapMenuItem(String name) {
    if (name == 'Logout') {
      handleLogout();
    }
  }

  void handleLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('token') && pref.containsKey('userInfo')) {
      pref.clear();
      Navigator.of(context).pop();
      Navigator.pushNamed((context), '/');
    }
  }

  void initState() {
    super.initState();

    Helper().getLoggedInUser().then((resp) {
      setState(() {
        loggedInUser = userModelFromJson(jsonEncode(resp));
      });
      print(loggedInUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 24, left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.lightBlue,
                  child: loggedInUser == null
                      ? Text('')
                      : Text(
                          Helper().getFirstTwoInitial(loggedInUser!.name),
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: loggedInUser == null
                        ? []
                        : <Widget>[
                            Text(
                              loggedInUser!.name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text(loggedInUser!.email),
                            ),
                          ],
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 24),
              itemCount: listMenu.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: ProfileMenuItem(index, listMenu[index]),
                  onTap: () {
                    handleTapMenuItem(listMenu[index].name);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
