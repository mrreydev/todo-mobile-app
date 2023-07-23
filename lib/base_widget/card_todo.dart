import 'package:flutter/material.dart';
import 'package:new_todo_app/model/todo_model.dart';

class CardTodo extends StatefulWidget {
  // const CardTodo({super.key});
  CardTodo(this.index, this.data);

  final int index;
  TodoModel data;

  @override
  State<CardTodo> createState() => _CardTodoState(index, data);
}

class _CardTodoState extends State<CardTodo> {
  final int index;
  TodoModel data;

  _CardTodoState(this.index, this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
        child: Card(
            color: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black54, width: 1),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                data.name,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
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
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              data.description,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ]))));
  }
}
