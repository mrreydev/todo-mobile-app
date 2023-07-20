import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (!pref.containsKey('token')) {
      return null;
    }

    return pref.getString('token')!;
  }

  getLoggedInUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (!pref.containsKey('userInfo')) {
      return null;
    }

    String userInfo = pref.getString('userInfo')!;
    return jsonDecode(userInfo);
  }

  getFirstTwoInitial(String name) {
    if (name == null || name == '') {
      return '';
    }

    final splitted = name.split(' ');

    var initials = '';

    for (int i = 0; i < splitted.length; i++) {
      if (i < 2) {
        initials = initials + splitted[i].substring(0, 1);
      }
    }
    return initials;
  }
}
