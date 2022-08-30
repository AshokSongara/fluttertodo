import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/todo/todo.dart';
import '../../blocs/todo/todo_bloc.dart';
import '../../blocs/todo_form/todo_form_bloc.dart';
import '../../widgets/todo/todo_card.dart';
import 'add_todo_page.dart';
import 'view_todo_page.dart';

class TodoHomePage extends StatefulWidget {
  static const routeName = '/TodoHomePage';

  const TodoHomePage({Key? key}) : super(key: key);

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  late Timer _timer;

  void _startOperation(Todo todo) {
    _timer = Timer(const Duration(milliseconds: 200), () {
      print('Do something after delay');
      BlocProvider.of<TodoFormBloc>(context).add(
        TodoFormRemoveEvent(
          task: todo,
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoFormBloc, TodoFormState>(
      listener: (BuildContext context, TodoFormState todoFormState) {
        if (todoFormState is TodoFormAddSuccessState) {
          context.read<TodoBloc>().add(GetTodoListEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TODO"),
        ),
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
                        print("Try to click details");
                        Navigator.pushNamed(
                          context,
                          ViewTodoPage.routeName,
                          arguments: ViewTodoPageArguments(
                            todoModel: state.todoList[index],
                          ),
                        );
                      },
                      child: GestureDetector(
                        onTapDown: (_) {
                          _startOperation(state.todoList[index]);
                        },
                        onTapUp: (_) {
                          _timer.cancel();
                        },
                        child: TodoCard(
                          key: ValueKey(index),
                          todoModel: state.todoList[index],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              );
            } else if (state is TodoLoadFailedState) {
              return const Center(
                child: Text("No Data"),
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
