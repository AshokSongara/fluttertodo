import 'package:fluttertodo/data/datasources/app_database.dart';
import 'package:fluttertodo/domain/usecases/todo/remove_todo.dart';
import 'package:fluttertodo/domain/usecases/todo/update_todo.dart';
import 'package:fluttertodo/utils/constants.dart';

import 'data/respositories/todo/todo_repository_impl.dart';
import 'domain/repositories/todo/todo_repository.dart';
import 'domain/usecases/todo/add_todo.dart';
import 'domain/usecases/todo/get_all_todo.dart';
import 'presentation/blocs/todo/todo_bloc.dart';
import 'presentation/blocs/todo_form/todo_form_bloc.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> init() async {
  // *
  final database =
      await $FloorAppDatabase.databaseBuilder(kDatabaseName).build();
  injector.registerSingleton<AppDatabase>(database);

  injector.registerFactory<TodoFormBloc>(
    () => TodoFormBloc(
        addTodo: injector(), removeTodo: injector(), updateTodo: injector()),
  );
  injector.registerFactory<TodoBloc>(
    () => TodoBloc(
      getAllTodo: injector(),
    ),
  );

  injector.registerLazySingleton(() => GetAllTodo(injector()));
  injector.registerLazySingleton(() => AddTodo(injector()));
  injector.registerLazySingleton(() => RemoveTodo(injector()));
  injector.registerLazySingleton(() => UpdateTodo(injector()));

  injector.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(appDatabase: injector()),
  );
}
