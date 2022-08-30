part of 'todo_form_bloc.dart';

abstract class TodoFormState extends Equatable {
  const TodoFormState();

  @override
  List<Object> get props => [];
}

class TodoFormInitialState extends TodoFormState {}

class TodoFormAddSuccessState extends TodoFormState {}

class TodoFormAddFailState extends TodoFormState {}

class TodoFormRemoveSuccessState extends TodoFormState {}

class TodoFormRemoveFailState extends TodoFormState {}

class TodoFormUpdateSuccessState extends TodoFormState {}

class TodoFormUpdateFailState extends TodoFormState {}

class TodoFormLoadingState extends TodoFormState {}
