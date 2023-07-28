import 'package:new_todo_app/model/todo_task_model.dart';

class TaskModel {
  int? id;
  String task;
  bool finished;

  TaskModel(this.id, this.task, this.finished);
}
