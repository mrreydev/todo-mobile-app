import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loadmore/loadmore.dart';
import 'package:new_todo_app/base_widget/card_todo.dart';

import 'package:new_todo_app/model/todo_model.dart';

import 'package:new_todo_app/model/todo_task_model.dart';
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

  late TodoTaskModel? detailTodo;

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

  showLoaderDialog(BuildContext context, int period) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading..."),
          )
        ],
      ),
    );

    late Timer _timer;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          _timer = Timer(Duration(seconds: period), () {
            Navigator.of(context).pop();
          });

          return alert;
        }).then(
      (value) {
        if (_timer.isActive) {
          _timer.cancel();
        }
      },
    );
  }

  void handleGetTodo(TodoModel data) async {
    showLoaderDialog(context, 5);
    try {
      final resp = await TodoViewModel().getTodo(data.id.toString());

      if (resp != null) {
        setState(() {
          detailTodo = todoTaskModelFromJson(jsonEncode(resp));
        });

        print(detailTodo?.name);
        Navigator.of(context, rootNavigator: true).pop();

        showDetailDialog(detailTodo!);
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        Fluttertoast.showToast(
            msg: "Gagal mendapatkan data todo",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red[800],
            textColor: Colors.white);
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Fluttertoast.showToast(
          msg: "Gagal mendapatkan data todo",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);
    }
  }

  void handleDeleteTodo(String id) async {
    try {
      showLoaderDialog(context, 30);
      final resp = await TodoViewModel().deleteTodo(id);

      if (resp != null) {
        Navigator.of(context, rootNavigator: true).pop();
        handleResetList();
        Fluttertoast.showToast(
            msg: "Berhasil Menghapus Todo",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.green[800],
            textColor: Colors.white);
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        Fluttertoast.showToast(
            msg: "Gagal menghapus todo",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red[800],
            textColor: Colors.white);
      }
    } catch (e) {
      print(e);
      Navigator.of(context, rootNavigator: true).pop();
      Fluttertoast.showToast(
          msg: "Gagal menghapus todo",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);
    }
  }

  showDetailDialog(TodoTaskModel data) {
    showDialog(
        context: context,
        builder: ((context) {
          return SimpleDialog(
            title: const Text('Hapus Todo?'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            data.name,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        data.important
                            ? Icon(
                                Icons.star,
                                color: Colors.yellow[700],
                              )
                            : Text('')
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "${data.description}",
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: Colors.deepPurple,
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              handleDeleteTodo(data.id.toString());
                            },
                            child: const Text('Hapus')),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        }));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void toEditTodo(TodoModel data) async {
    Navigator.pushNamed(
      context,
      '/edit-todo',
      arguments: {'todoId': data.id},
    );
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
                    return GestureDetector(
                      onLongPress: () {
                        handleGetTodo(todos[index]);
                      },
                      onTap: () {
                        toEditTodo(todos[index]);
                      },
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(14.0, 0, 14.0, 0),
                          child: CardTodo(index, todos[index])),
                    );
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
