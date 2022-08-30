import '../../../core/usecases/usecase.dart';
import '../../repositories/todo/todo_repository.dart';
import 'package:equatable/equatable.dart';

class AddTodo implements UseCase<void, Params> {
  final TodoRepository todoRepository;

  AddTodo(this.todoRepository);

  @override
  Future<void> call(Params params) {
    return todoRepository.addTodo(params.task);
  }
}

class Params extends Equatable {
  final String task;

  Params({required this.task});

  @override
  List<Object> get props => [task];
}
