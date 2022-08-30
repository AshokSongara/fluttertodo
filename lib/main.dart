import 'core/theme/dark_theme_data.dart';
import 'presentation/blocs/todo_form/todo_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/route/route.dart';
import 'presentation/blocs/todo/todo_bloc.dart';
import 'presentation/pages/todo/todo_home_page.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<TodoFormBloc>(
          create: (context) => injector<TodoFormBloc>(),
        ),
        BlocProvider<TodoBloc>(
          create: (context) => injector<TodoBloc>()..add(GetTodoListEvent()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DoneIt',
      theme: darkThemeData,
      themeMode: ThemeMode.dark,
      darkTheme: darkThemeData,
      home: TodoHomePage(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
