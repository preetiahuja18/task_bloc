// task_state.dart

import 'package:task_bloc/domain/entities/task.dart' show Task;

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded({required this.tasks});
}

class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});
}
