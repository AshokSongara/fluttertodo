import 'package:floor/floor.dart';
import 'package:fluttertodo/domain/entities/todo/todo.dart';
import 'package:fluttertodo/utils/constants.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM $kTodosTableName')
  Future<List<Todo>> getAllTodosList();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertTodo(Todo todo);

  @delete
  Future<void> deleteTodo(Todo todo);

  @update
  Future<void> updateTodo(Todo todo);
}