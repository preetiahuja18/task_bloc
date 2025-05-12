import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_bloc/data/datasources/todo_local_data_source.dart';
import 'package:task_bloc/data/repositories/todo_repo_impl.dart';
import 'package:task_bloc/domain/repositories/todo_repository.dart';
import 'package:task_bloc/presentation/bloc/todo_bloc.dart';
import 'package:task_bloc/presentation/bloc/todo_event.dart';
import 'package:task_bloc/presentation/pages/todo_page.dart'; 

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Provide TodoLocalDataSource first, if it needs initialization
        Provider<TodoLocalDataSource>(
          create: (_) => TodoLocalDataSource(), 
        ),
        // Provide TodoRepoImpl with TodoLocalDataSource injected
        ProxyProvider<TodoLocalDataSource, TodoRepository>(
          update: (context, todoLocalDataSource, previous) => TodoRepoImpl(todoLocalDataSource),
        ),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
    theme: ThemeData(
  useMaterial3: true,
  colorSchemeSeed: Colors.black, // Sets black as the base theme color
  //brightness: Brightness.light,
),

      home: BlocProvider(
        create: (context) => TodoBloc(todoRepository: context.read<TodoRepository>())..add(LoadTodosEvent()),
        child: TodoPage(),
      ),
    );
  }
}
