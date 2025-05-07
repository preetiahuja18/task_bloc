
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bloc/domain/repositories/task_repo_impl.dart';
import 'package:task_bloc/domain/usecasees/add_task.dart' show AddTask;
import 'package:task_bloc/domain/usecasees/get_task.dart' show GetTasks;
import 'package:task_bloc/domain/usecasees/remove_task.dart';
import 'package:task_bloc/domain/usecasees/task_status.dart';
import 'package:task_bloc/presentation/bloc/task_bloc.dart';
import 'package:task_bloc/presentation/bloc/task_event.dart';
import 'package:task_bloc/presentation/screens/home_screen.dart';

import 'data/datasources/task_local_datasource.dart';

void main() {
 void main() {
  final dataSource = TaskLocalDataSourceImpl(); // Use concrete class here
  final repository = TaskRepositoryImpl(dataSource);

  runApp(MyApp(repository: repository));
}

}

class MyApp extends StatelessWidget {
  final TaskRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      home: BlocProvider(
        create: (context) => TaskBloc(
          getTasks: GetTasks(repository),
          addTask: AddTask(repository),
          removeTask: RemoveTask(repository),
          toggleTaskStatus: ToggleTaskStatus(repository),
        )..add(LoadTasks()),
        child: const HomeScreen(),
      ),
    );
  }
}
