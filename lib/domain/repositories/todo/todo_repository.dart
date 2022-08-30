import '../../entities/todo/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getAllTodo();

  Future<dynamic> addTodo(String task);

  Future<void> removeTodo(Todo task);

  Future<void> updateTodo(Todo task);
}
