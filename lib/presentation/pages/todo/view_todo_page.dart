import 'package:fluttertodo/utils/constants.dart';

import '../../../data/models/todo/todo_model.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/todo/todo.dart';

class ViewTodoPage extends StatelessWidget {
  static const routeName = '/ViewTodoPage';

  final Todo todoModel;

  const ViewTodoPage({Key? key, required this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SelectableText(
                getTaskFullBody(todoModel.task),
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewTodoPageArguments {
  final Todo todoModel;

  ViewTodoPageArguments({required this.todoModel});
}
