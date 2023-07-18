import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:new_todo_app/base_widget/profile_menu_item.dart';
import 'package:new_todo_app/model/profile_menu_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ProfileMenuModel> listMenu = [
    ProfileMenuModel('Edit profile', '/', Colors.black87),
    ProfileMenuModel('Ganti password', '/', Colors.black87),
    ProfileMenuModel('Logout', '/', Colors.red)
  ];

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
                  child: Text(
                    'VM',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Vitrual Machine',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text('Eleague Major'),
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
                    print(listMenu[index].name);
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
