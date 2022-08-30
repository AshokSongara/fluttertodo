import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/todo/todo_bloc.dart';
import '../../blocs/todo_form/todo_form_bloc.dart';
import '../../widgets/todo/todo_card.dart';
import 'add_todo_page.dart';
import 'view_todo_page.dart';

class TodoHomePage extends StatelessWidget {
  static const routeName = '/TodoHomePage';

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoFormBloc, TodoFormState>(
      listener: (BuildContext context, TodoFormState todoFormState) {
        if (todoFormState is TodoFormAddSuccessState) {
          context.read<TodoBloc>().add(GetTodoListEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("TODO"),),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (BuildContext context, TodoState state) {
            if (state is TodoInitialState) {
              return const Center(
                child: Text("Initial State"),
              );
            } else if (state is TodoLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TodoLoadSuccessState) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ViewTodoPage.routeName,
                          arguments: ViewTodoPageArguments(
                            todoModel: state.todoList[index],
                          ),
                        );
                      },
                      child: TodoCard(
                        key: ValueKey(index),
                        todoModel: state.todoList[index],
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              );
            } else if (state is TodoLoadFailedState) {
              return const Center(
                child: Text("Error Loading"),
              );
            } else {
              return const Center(
                child: Text("Unexpected State"),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, AddTodoPage.routeName);
          },
        ),
      ),
    );
  }
}
