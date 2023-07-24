// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

List<TodoModel> todoModelFromJson(String str) =>
    List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel {
  int id;
  int userId;
  String name;
  String description;
  dynamic dueDate;
  bool remindMe;
  bool important;
  DateTime createdAt;
  DateTime updatedAt;

  TodoModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    this.dueDate,
    required this.remindMe,
    required this.important,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        description: json["description"],
        dueDate: json["due_date"],
        remindMe: json["remind_me"],
        important: json["important"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
      };
}
