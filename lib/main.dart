// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task_bloc/presentation/task_Screen.dart';

// import 'bloc/task_bloc.dart';
// import 'bloc/task_event.dart';
// import 'domain/repositories/task_repo_impl.dart';
// import 'domain/usecasees/add_task.dart';
// import 'domain/usecasees/get_task.dart';
// import 'domain/usecasees/remove_task.dart';
// import 'domain/usecasees/task_status.dart';
// void main() {
//   final repository = TaskRepositoryImpl();

//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BlocProvider(
//         create: (_) => TaskBloc(
//           addTaskUseCase: AddTaskUseCase(repository),
//           toggleTaskUseCase: ToggleTaskUseCase(repository),
//           deleteTaskUseCase: DeleteTaskUseCase(repository),
//           getTasksUseCase: GetTasksUseCase(repository),
//         )..add(LoadTasksEvent()),
//         child: HomeScreen(),
//       ),
//     ),
//   );
// }