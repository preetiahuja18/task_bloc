import '../../domain/entities/task.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;
  AddTaskEvent(this.task);
}

class RemoveTaskEvent extends TaskEvent {
  final Task task;
  RemoveTaskEvent(this.task);
}

class ToggleTaskStatusEvent extends TaskEvent {
  final Task task;
  ToggleTaskStatusEvent(this.task);
}
