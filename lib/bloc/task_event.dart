import '../../domain/entities/task.dart';

abstract class TaskEvent {}

class LoadTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String taskTitle;
  AddTaskEvent(this.taskTitle);
}

class ToggleTaskEvent extends TaskEvent {
  final int index;
  ToggleTaskEvent(this.index);
}

class DeleteTaskEvent extends TaskEvent {
  final int index;
  DeleteTaskEvent(this.index);
}