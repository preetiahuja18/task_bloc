import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bloc/domain/entities/task.dart';
import 'package:task_bloc/domain/usecasees/get_task.dart';
import 'package:task_bloc/domain/usecasees/add_task.dart';
import 'package:task_bloc/domain/usecasees/remove_task.dart';
import 'package:task_bloc/domain/usecasees/task_status.dart';
import 'package:task_bloc/presentation/bloc/task_event.dart';
import 'package:task_bloc/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final RemoveTask removeTask;
  final ToggleTaskStatus toggleTaskStatus;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.removeTask,
    required this.toggleTaskStatus,
  }) : super(TaskInitial());

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is LoadTasks) {
      yield* _mapLoadTasksToState();
    } else if (event is AddTaskEvent) {
      yield* _mapAddTaskToState(event.task);
    } else if (event is RemoveTaskEvent) {
      yield* _mapRemoveTaskToState(event.task);
    } else if (event is ToggleTaskStatusEvent) {
      yield* _mapToggleTaskStatusToState(event.task);
    }
  }

  Stream<TaskState> _mapLoadTasksToState() async* {
    yield TaskLoading();
    try {
      final tasks = await getTasks();
      yield TaskLoaded(tasks: tasks);
    } catch (e) {
      yield TaskError(message: e.toString());
    }
  }

  Stream<TaskState> _mapAddTaskToState(Task task) async* {
    try {
      await addTask(task);
      add(LoadTasks()); // Refresh tasks after adding one
    } catch (e) {
      yield TaskError(message: e.toString());
    }
  }

  Stream<TaskState> _mapRemoveTaskToState(Task task) async* {
    try {
      await removeTask(task);
      add(LoadTasks()); // Refresh tasks after removal
    } catch (e) {
      yield TaskError(message: e.toString());
    }
  }

  Stream<TaskState> _mapToggleTaskStatusToState(Task task) async* {
    try {
      await toggleTaskStatus(task);
      add(LoadTasks()); // Refresh tasks after toggling the status
    } catch (e) {
      yield TaskError(message: e.toString());
    }
  }
}
