import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_todo_app/model/user_model.dart';
import 'package:new_todo_app/helper.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel {
  /**
   * Login User
   */
  Future login(String email, String password) async {
    Map data = {"email": email, "password": password};

    try {
      String? url = dotenv.env['BASE_URL'];
      http.Response resp = await http.post(Uri.parse(url! + '/auth/login'),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: jsonEncode(data));
      if (resp.statusCode == 200) {
        final parsedJson = jsonDecode(resp.body);
        final data = parsedJson['data']['token'];
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("error login: $e");
      return null;
    }
  }

  /**
   * Register User
   */
  Future register(String name, String phone, String email, String password,
      String confirmPassword) async {
    Map data = {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "role": "general"
    };

    try {
      String? url = dotenv.env['BASE_URL'];
      http.Response resp = await http.post(Uri.parse(url! + '/auth/register'),
          headers: {"Accept": "application/json"}, body: json.encode(data));

      if (resp.statusCode == 201) {
        final parsedJson = jsonDecode(resp.body);
        final data = parsedJson['message'];
        return data;
      } else {
        return false;
      }
    } catch (e) {
      print("error register: $e");
      return null;
    }
  }

  /**
   * Get LoggedIn User
   */
  Future loggedInUser() async {
    final token = await Helper().getToken();

    if (token == null) {
      return null;
    }

    try {
      String? url = dotenv.env['BASE_URL'];
      http.Response resp =
          await http.get(Uri.parse(url! + '/auth/users'), headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token
      });

      if (resp.statusCode == 200) {
        final parsedJson = jsonDecode(resp.body);
        final data = userModelFromJson(jsonEncode(parsedJson['data']));
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("error register: $e");
      return null;
    }
  }
}
