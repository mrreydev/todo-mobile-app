// To parse this JSON data, do
//
//     final todoTaskModel = todoTaskModelFromJson(jsonString);

import 'dart:convert';

TodoTaskModel todoTaskModelFromJson(String str) =>
    TodoTaskModel.fromJson(json.decode(str));

String todoTaskModelToJson(TodoTaskModel data) => json.encode(data.toJson());

class TodoTaskModel {
  int id;
  int userId;
  String name;
  String description;
  dynamic dueDate;
  bool remindMe;
  bool important;
  DateTime createdAt;
  DateTime updatedAt;
  List<Task> tasks;

  TodoTaskModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    this.dueDate,
    required this.remindMe,
    required this.important,
    required this.createdAt,
    required this.updatedAt,
    required this.tasks,
  });

  factory TodoTaskModel.fromJson(Map<String, dynamic> json) => TodoTaskModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        description: json["description"],
        dueDate: json["due_date"],
        remindMe: json["remind_me"],
        important: json["important"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "description": description,
        "due_date": dueDate,
        "remind_me": remindMe,
        "important": important,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
      };
}

class Task {
  int id;
  int todoId;
  String task;
  bool finished;
  dynamic createdAt;
  DateTime? updatedAt;

  Task({
    required this.id,
    required this.todoId,
    required this.task,
    required this.finished,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        todoId: json["todo_id"],
        task: json["task"],
        finished: json["finished"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo_id": todoId,
        "task": task,
        "finished": finished,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
