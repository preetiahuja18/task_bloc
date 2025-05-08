// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../domain/usecasees/add_task.dart';
// import '../domain/usecasees/get_task.dart';
// import '../domain/usecasees/remove_task.dart';
// import '../domain/usecasees/task_status.dart';
// import 'task_event.dart';
// import 'task_state.dart';

// class TaskBloc extends Bloc<TaskEvent, TaskState> {
//  // final AddTaskUseCase addTaskUseCase;
//   final ToggleTaskUseCase toggleTaskUseCase;
//   final DeleteTaskUseCase deleteTaskUseCase;
//   final GetTasksUseCase getTasksUseCase;

//   TaskBloc({
//    // required this.addTaskUseCase,
//     required this.toggleTaskUseCase,
//     required this.deleteTaskUseCase,
//     required this.getTasksUseCase,
//   }) : super(TaskInitialState()) {
//     on<LoadTasksEvent>(onLoadTasks);
//    // on<AddTaskEvent>(onAddTask);
//     on<ToggleTaskEvent>(onToggleTask);
//     on<DeleteTaskEvent>(onDeleteTask);
//   }

//   Future<void> onLoadTasks(LoadTasksEvent event, Emitter<TaskState> emit) async {
//     emit(TaskLoadingState());
//     try {
//       final tasks = await getTasksUseCase.execute();
//       emit(TaskLoadedState(tasks));
//     } catch (e) {
//       emit(TaskErrorState("Failed to load tasks"));
//     }
//   }

//   // Future<void> onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
//   //   try {
//   //     await addTaskUseCase.execute(event.taskTitle);
//   //     add(LoadTasksEvent());
//   //   } catch (e) {
//   //     emit(TaskErrorState("Failed to add task"));
//   //   }
//   // }

//   Future<void> onToggleTask(ToggleTaskEvent event, Emitter<TaskState> emit) async {
//     try {
//       await toggleTaskUseCase.execute(event.index);
//       add(LoadTasksEvent());
//     } catch (e) {
//       emit(TaskErrorState("Failed to toggle task"));
//     }
//   }

//   Future<void> onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
//     try {
//       await deleteTaskUseCase.execute(event.index);
//       add(LoadTasksEvent());
//     } catch (e) {
//       emit(TaskErrorState("Failed to delete task"));
//     }
//   }
// }