import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/todo/todo.dart';
import '../../../domain/repositories/todo/todo_repository.dart';
import '../../datasources/app_database.dart';

class TodoRepositoryImpl implements TodoRepository {
  final AppDatabase appDatabase;

  TodoRepositoryImpl({required this.appDatabase});

  @override
  Future<List<Todo>> getAllTodo() async {
    return await appDatabase.todoDao.getAllTodosList();
  }

  @override
  Future<dynamic> addTodo(String task) async {
    try {
      return await appDatabase.todoDao.insertTodo(Todo(task: task, id: null));
    } on DataBaseException {
      return DataBaseFailure();
    }
  }

  @override
  Future<void> removeTodo(Todo task) async {
    return await appDatabase.todoDao.deleteTodo(task);
  }

  @override
  Future<void> updateTodo(Todo task) async {
    return await appDatabase.todoDao.updateTodo(task);
  }
}
