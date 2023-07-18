import 'package:flutter/material.dart';
import 'package:new_todo_app/model/profile_menu_model.dart';

class ProfileMenuItem extends StatelessWidget {
  // const ProfileMenuItem({super.key});

  final int index;
  final ProfileMenuModel data;
  final VoidCallback? onTap;

  const ProfileMenuItem(
    this.index,
    this.data, {
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.transparent,
        child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            child: Text(
              data.name,
              style: TextStyle(color: data.color, fontSize: 16.0),
            )),
      ),
    );
  }
}
