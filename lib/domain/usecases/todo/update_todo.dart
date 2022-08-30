import 'package:fluttertodo/domain/entities/todo/todo.dart';

import '../../../core/usecases/usecase.dart';
import '../../repositories/todo/todo_repository.dart';

class UpdateTodo implements UseCase<void, Todo> {
  final TodoRepository todoRepository;

  UpdateTodo(this.todoRepository);

  @override
  Future<void> call(Todo params) async {
    return await todoRepository.updateTodo(params);
  }
}
