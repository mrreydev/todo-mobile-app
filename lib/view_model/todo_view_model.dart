import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:new_todo_app/model/user_model.dart';
import 'package:new_todo_app/helper.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class TodoViewModel {
  /**
   * Get Todo List
   */
  Future getTodos(int page, [String? search, bool? important]) async {
    final token = await Helper().getToken();

    if (token == null) {
      return null;
    }

    try {
      final params = {'page': page, 'search': search ?? ''};

      String? baseUrl = dotenv.env['BASE_URL'];
      String combineUrl =
          baseUrl! + '/todos?page=' + page.toString() + '&search=$search';

      if (important != null) {
        combineUrl += '&important=$important';
      }

      var url = Uri.parse(combineUrl);

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

  /**
   * Get Todo
   */
  Future getTodo(String id) async {
    final token = await Helper().getToken();

    if (token == null) {
      return null;
    }

    try {
      String? baseUrl = dotenv.env['BASE_URL'];
      String combineUrl = baseUrl! + '/todos/$id';

      var url = Uri.parse(combineUrl);

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
      print("get todo: $e");
      return null;
    }
  }

  /**
   * Delete Todo
   */
  Future deleteTodo(String id) async {
    final token = await Helper().getToken();

    if (token == null) {
      return null;
    }

    try {
      String? baseUrl = dotenv.env['BASE_URL'];
      String combineUrl = baseUrl! + '/todos/$id';

      var url = Uri.parse(combineUrl);

      http.Response resp = await http.delete(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer " + token,
      });

      if (resp.statusCode == 200) {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      print("delete todo: $e");
      return null;
    }
  }
}
