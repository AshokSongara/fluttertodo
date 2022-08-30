import 'package:flutter/material.dart';
import 'package:fluttertodo/presentation/pages/todo/update_todo_page.dart';

import '../../../domain/entities/todo/todo.dart';
import '../../../utils/constants.dart';
import '../../pages/todo/view_todo_page.dart';

class TodoCard extends StatelessWidget {
  final Todo todoModel;

  const TodoCard({Key? key, required this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          UpdateTodoPage.routeName,
          arguments: ViewUpdateTodoPageArguments(
            todoModel: todoModel,
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getTaskTitle(todoModel.task),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getTaskBodyPreview(todoModel.task),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
