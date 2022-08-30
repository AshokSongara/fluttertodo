import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fluttertodo/domain/usecases/todo/remove_todo.dart';
import 'package:fluttertodo/domain/usecases/todo/update_todo.dart';
import '../../../domain/entities/todo/todo.dart';
import '../../../domain/usecases/todo/add_todo.dart';
import 'package:equatable/equatable.dart';

part 'todo_form_event.dart';

part 'todo_form_state.dart';

class TodoFormBloc extends Bloc<TodoFormEvent, TodoFormState> {
  TodoFormBloc(
      {required this.addTodo,
      required this.removeTodo,
      required this.updateTodo})
      : super(TodoFormInitialState()) {
    print("TodoFormBloc : constructor");
  }

  final AddTodo addTodo;

  final RemoveTodo removeTodo;

  final UpdateTodo updateTodo;

  @override
  Stream<TodoFormState> mapEventToState(
    TodoFormEvent event,
  ) async* {
    if (event is TodoFormAddEvent) {
      yield TodoFormLoadingState();
      await addTodo(Params(task: event.task));
      yield TodoFormAddSuccessState();
    }

    if (event is TodoFormRemoveEvent) {
      yield TodoFormLoadingState();
      await removeTodo(Todo(task: event.task.task, id: event.task.id));
      yield TodoFormAddSuccessState();
    }

    if (event is TodoFormUpdateEvent) {
      yield TodoFormLoadingState();
      await updateTodo(Todo(task: event.task.task, id: event.task.id));
      yield TodoFormAddSuccessState();
    }
  }

  @override
  void onTransition(Transition<TodoFormEvent, TodoFormState> transition) {
    print("TodoFormBloc : $transition");
    super.onTransition(transition);
  }
}
