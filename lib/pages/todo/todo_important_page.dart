import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:new_todo_app/base_widget/card_todo.dart';

import 'package:new_todo_app/model/todo_model.dart';
import 'package:new_todo_app/view_model/todo_view_model.dart';

class TodoImportantPage extends StatefulWidget {
  const TodoImportantPage({super.key});

  @override
  State<TodoImportantPage> createState() => _TodoImportantPageState();
}

class _TodoImportantPageState extends State<TodoImportantPage> {
  String inputSearch = "";
  late final TextEditingController _inputSearchController =
      TextEditingController();

  int page = 1, totalPage = 1;
  List todos = [];
  Timer? _debounce;

  void _changeInputSearch(value) {
    setState(() {
      inputSearch = value;
    });
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _changeInputSearch(query);
      handleResetList();
    });
  }

  Future<bool> handleGetTodos() async {
    final resp = await TodoViewModel().getTodos(page, inputSearch, true);

    if (resp != null) {
      List local = todoModelFromJson(jsonEncode(resp['data']));
      setState(() {
        page++;
      });

      if (local.isNotEmpty) {
        setState(() {
          todos.addAll(local);
          totalPage = resp['last_page'];
        });
      }
    }

    return true;
  }

  Future<void> handleResetList() async {
    setState(() {
      page = 1;
      totalPage = 1;
      todos = [];
    });
  }

  void resetSearch() {
    setState(() {
      inputSearch = "";
      _inputSearchController.text = "";
    });

    handleResetList();
  }

  String language() {
    return "";
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
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
                controller: _inputSearchController,
                onChanged: (value) => {_onSearchChanged(value)},
                decoration: InputDecoration(
                    suffixIcon: inputSearch == ""
                        ? Icon(Icons.search)
                        : GestureDetector(
                            onTap: () {
                              resetSearch();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.deepPurple,
                            ),
                          ),
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
            child: RefreshIndicator(
              onRefresh: handleResetList,
              child: LoadMore(
                isFinish: page > totalPage,
                onLoadMore: handleGetTodos,
                whenEmptyLoad: true,
                delegate: const DefaultLoadMoreDelegate(),
                textBuilder: DefaultLoadMoreTextBuilder.english,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
                        child: CardTodo(index, todos[index]));
                  },
                  itemCount: todos.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
