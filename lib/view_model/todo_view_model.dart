import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_todo_app/model/user_model.dart';
import 'package:new_todo_app/helper.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class TodoViewModel {
  /**
   * Get Todo List
   */
  Future getTodos(int page, [String? search]) async {
    final token = await Helper().getToken();

    if (token == null) {
      return null;
    }
    print(page);

    try {
      final params = {'page': page, 'search': search ?? ''};

      String? baseUrl = dotenv.env['BASE_URL'];
      var url = Uri.parse(
          baseUrl! + '/todos?page=' + page.toString() + '&search=$search');

      print(url);
      http.Response resp = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token,
      });

      if (resp.statusCode == 200) {
        final parsedJson = jsonDecode(resp.body);
        final data = parsedJson['data'];

        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("get todos: $e");
      return null;
    }
  }
}
