// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task_bloc/presentation/bloc/task_bloc.dart';
// import '../../domain/entities/task.dart';
// import '../bloc/task_bloc.dart';
// import '../bloc/task_event.dart';

// class TaskTile extends StatelessWidget {
//   final Task task;

//   const TaskTile({super.key, required this.task});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(
//         task.title,
//         style: TextStyle(
//           decoration: task.isCompleted ? TextDecoration.lineThrough : null,
//         ),
//       ),
//       trailing: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: () {
//               context.read<TaskBloc>().add(ToggleTaskStatusEvent(task));
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete),
//             onPressed: () {
//               context.read<TaskBloc>().add(RemoveTaskEvent(task));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
