
// import 'package:task_bloc/data/task_local_datasource.dart';

// import '../../domain/entities/task.dart';

// class TaskRepository {
//   final TaskLocalDataSource _taskLocalDataSource = TaskLocalDataSource();

//   Future<List<Task>> getTasks() async {
//     return await _taskLocalDataSource.getTasks();
//   }

//   Future<void> addTask(String taskTitle) async {
//     return await _taskLocalDataSource.addTask(Task(title: taskTitle, completed: false));
//   }

//   Future<void> toggleTask(int index) async {
//     return await _taskLocalDataSource.toggleTask(index);
//   }

//   Future<void> deleteTask(int index) async {
//     return await _taskLocalDataSource.deleteTask(index);
//   }
// }