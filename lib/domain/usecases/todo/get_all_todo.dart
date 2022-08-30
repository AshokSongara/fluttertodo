import '../../../core/usecases/usecase.dart';
import '../../entities/todo/todo.dart';
import '../../repositories/todo/todo_repository.dart';

class GetAllTodo implements UseCase<List<Todo>, NoParams> {
  final TodoRepository todoRepository;

  GetAllTodo(this.todoRepository);

  @override
  Future<List<Todo>> call(NoParams noParams) async {
    return await todoRepository.getAllTodo();
  }
}
