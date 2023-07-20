import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (!pref.containsKey('token')) {
      return null;
    }

    return pref.getString('token')!;
  }
}
