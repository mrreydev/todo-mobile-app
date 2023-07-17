import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CardTodo extends StatefulWidget {
  const CardTodo({super.key});

  @override
  State<CardTodo> createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo> {
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
                                'Todo title man wings zero ew verka oawkoawk',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow[700],
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: const <Widget>[
                          Expanded(
                            child: Text(
                              'Lorem ipsum dolor sit amet consectetur. Ultrices sed faucibus egestas non posuere ornare sed nam. Sem mauris nunc et quis ut at.',
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
