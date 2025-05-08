import '../../domain/entities/task.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;
  TaskLoadedState(this.tasks);
}

class TaskErrorState extends TaskState {
  final String message;
  TaskErrorState(this.message);
}