import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_todo_app/model/task_model.dart';
import 'package:new_todo_app/model/todo_task_model.dart';
import 'package:new_todo_app/view_model/todo_view_model.dart';

class EditTodoPage extends StatefulWidget {
  final Object? arguments;
  EditTodoPage(this.arguments);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState(arguments);
}

class _EditTodoPageState extends State<EditTodoPage> {
  final Object? arguments;
  _EditTodoPageState(this.arguments);
  late String id = "";

  late final TextEditingController _textNamaController =
      TextEditingController();
  late final TextEditingController _textDescriptionController =
      TextEditingController();
  late final TextEditingController _textDueDateController =
      TextEditingController();
  late final TextEditingController _taskInputController =
      TextEditingController();

  late String name = "", description = "", dueDate = "", task = "";
  late bool remindMe = false, important = false, edit = false;

  late List listTask = [];
  late TaskModel editedTask;
  bool isTaskEdit = false;
  int indexEditedTask = -1;

  late TodoTaskModel editedTodo;

  @override
  void initState() {
    super.initState();

    final tag = (arguments ?? <String, dynamic>{}) as Map;
    handleGetTodo(tag['todoId']);
  }

  void handleGetTodo(int id) async {
    try {
      final resp = await TodoViewModel().getTodo(id.toString());

      if (resp != null) {
        setState(() {
          editedTodo = todoTaskModelFromJson(jsonEncode(resp));
        });

        setEditedTodoForm();
      }
    } catch (error) {
      print('error get todo: $error');
      Fluttertoast.showToast(
          msg: "Gagal Mengubah Todo, silahkan coba kembali",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);
      Navigator.of(context).pop();
      Navigator.pushNamed((context), '/homepage');
    }
  }

  void setEditedTodoForm() {
    _textNamaController.text = editedTodo.name;
    _textDescriptionController.text = editedTodo.description;
    _textDueDateController.text =
        editedTodo.dueDate == null ? '' : editedTodo.dueDate;

    name = editedTodo.name;
    description = editedTodo.description;
    dueDate = editedTodo.dueDate == null ? '' : editedTodo.dueDate;

    setState(() {
      remindMe = editedTodo.remindMe;
      important = editedTodo.important;
    });

    editedTodo.tasks.forEach((task) {
      TaskModel setFormTask = new TaskModel(task.id, task.task, task.finished);

      setState(() {
        listTask.add(setFormTask);
      });
    });
  }

  void _changeName(value) {
    setState(() {
      name = value;
    });
  }

  void _changeDescription(value) {
    setState(() {
      description = value;
    });
  }

  void _changeDueDate(value) {
    setState(() {
      dueDate = value;
    });
  }

  void _changeTask(value) {
    setState(() {
      task = value;
    });
  }

  void _changeRemindMe(value) {
    setState(() {
      remindMe = value;
    });
  }

  void _changeImportant(value) {
    setState(() {
      important = value;
    });
  }

  void _changeEdit(value) {
    setState(() {
      edit = value;
    });
  }

  void _openDialogTask() {
    showDialog(
        context: context,
        builder: ((context) {
          return SimpleDialog(
              title: const Text('Tambah Task'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                          controller: _taskInputController,
                          onChanged: (value) => {_changeTask(value)},
                          decoration: InputDecoration(
                              suffixIcon: task == ""
                                  ? null
                                  : GestureDetector(
                                      onTap: () {
                                        // resetSearch();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                              hintText: 'Masukan Task.',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.deepPurple, width: 2.0),
                              ))),
                      const SizedBox(
                        height: 8.0,
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
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                if (isTaskEdit) {
                                  handleEditTask();
                                } else {
                                  handleAddTask();
                                }
                                _taskInputController.text = "";
                              },
                              child: Text('Simpan')),
                        ],
                      )
                    ],
                  ),
                )
              ]);
        }));
  }

  void handleAddTask() {
    TaskModel newTask = TaskModel(null, task, false);
    setState(() {
      listTask.add(newTask);
    });
  }

  handleDeleteTask(int index) {
    setState(() {
      listTask.removeAt(index);
    });
  }

  handleEditTask() {
    TaskModel newEdited = TaskModel(editedTask.id, task, editedTask.finished);

    setState(() {
      listTask[indexEditedTask] = newEdited;
      isTaskEdit = false;
      task = "";
      _taskInputController.text = "";
    });
  }

  handleChangeFinished(TaskModel data, int index, bool value) {
    TaskModel newEdited = TaskModel(data.id, data.task, value);

    setState(() {
      listTask[index] = newEdited;
    });
  }

  setEditTask(TaskModel data, int index) {
    setState(() {
      isTaskEdit = true;
      editedTask = data;
      task = data.task;
      _taskInputController.text = data.task;
      indexEditedTask = index;
    });
    _openDialogTask();
  }

  displayTask(TaskModel data, int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(data.task),
            Row(
              children: [
                Icon(Icons.edit),
                GestureDetector(
                  onTap: () {
                    print(index);
                  },
                  child: Icon(Icons.delete),
                )
              ],
            )
          ],
        ));
  }

  void handleSaveTodo() async {
    if (name == "" ||
        description == "" ||
        dueDate == "" ||
        listTask.length == 0) {
      Fluttertoast.showToast(
          msg: "Form Todo Wajib Diisi",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);
      return;
    }

    try {
      final resp = await TodoViewModel().updateTodo(editedTodo.id.toString(),
          name, description, dueDate, remindMe, important, listTask);

      if (resp != null) {
        Fluttertoast.showToast(
            msg: "Berhasil Mengubah Todo",
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.green[800],
            textColor: Colors.white);
        Navigator.of(context).pop();
        Navigator.pushNamed((context), '/homepage');
      }
    } catch (error) {
      print(error);
      Fluttertoast.showToast(
          msg: "Gagal Mengubah Todo, silahkan coba kembali",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red[800],
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple[700],
        title: const Text(
          'Edit todo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Nama todo',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: _textNamaController,
                      onChanged: (value) {
                        _changeName(value);
                      },
                      decoration: const InputDecoration(
                          hintText: 'Masukan nama todo',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 2.0),
                          )),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Deskripsi',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: _textDescriptionController,
                      onChanged: (value) {
                        _changeDescription(value);
                      },
                      decoration: const InputDecoration(
                          hintText: 'Masukan deskripsi todo',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 2.0),
                          )),
                    ),
                    const SizedBox(height: 24.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Tenggat waktu',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: _textDueDateController,
                      onChanged: (value) {
                        _changeDueDate(value);
                      },
                      decoration: const InputDecoration(
                          hintText: 'Masukan tenggat waktu',
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 2.0),
                          )),
                    ),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Remind Me'),
                activeColor: Colors.deepPurple[600],
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                dense: true,
                value: remindMe,
                onChanged: (bool? value) {
                  _changeRemindMe(value);
                },
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Important'),
                activeColor: Colors.deepPurple[600],
                contentPadding: const EdgeInsets.symmetric(horizontal: 6),
                dense: true,
                value: important,
                onChanged: (bool? value) {
                  _changeImportant(value);
                },
              ),
              Column(
                children: [
                  for (var i = 0; i < listTask.length; i++)
                    // displayTask(listTask[i], i)
                    Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(listTask[i].task),
                            Row(
                              children: [
                                Checkbox(
                                    activeColor: Colors.deepPurple,
                                    value: listTask[i].finished,
                                    onChanged: (value) {
                                      handleChangeFinished(
                                          listTask[i], i, value!);
                                    }),
                                GestureDetector(
                                  onTap: () {
                                    setEditTask(listTask[i], i);
                                  },
                                  child: Icon(Icons.edit),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    handleDeleteTask(i);
                                  },
                                  child: Icon(Icons.delete),
                                )
                              ],
                            )
                          ],
                        ))
                ],
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: OutlinedButton(
                  onPressed: () {
                    _openDialogTask();
                  },
                  child: Text(
                    '+ Tambah task',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      side: BorderSide(width: 1.0, color: Colors.deepPurple)),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.deepPurple,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                handleSaveTodo();
              },
              child: const Text('Simpan'))),
    );
  }
}
