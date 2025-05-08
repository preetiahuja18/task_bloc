// import 'package:shared_preferences/shared_preferences.dart';


// import 'dart:convert';
// import '../../domain/entities/task.dart';
// import '../model/task_model.dart';

// class TaskLocalDataSource {
//   Future<List<Task>> getTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final tasksString = prefs.getString('tasks') ?? '[]';
//     final List<dynamic> taskJson = json.decode(tasksString);
//     return taskJson.map((task) => TaskModel.fromJson(task)).toList();
//   }

//   Future<void> addTask(Task task) async {
//     final prefs = await SharedPreferences.getInstance();
//     final tasksString = prefs.getString('tasks') ?? '[]';
//     final List<dynamic> taskJson = json.decode(tasksString);
//     taskJson.add(TaskModel(title: task.title, completed: task.completed).toJson());
//     await prefs.setString('tasks', json.encode(taskJson));
//   }

//   Future<void> toggleTask(int index) async {
//     final prefs = await SharedPreferences.getInstance();
//     final tasksString = prefs.getString('tasks') ?? '[]';
//     final List<dynamic> taskJson = json.decode(tasksString);
//     final taskModel = TaskModel.fromJson(taskJson[index]);
//     final updatedTask = taskModel.copyWith(completed: !taskModel.completed);
//     taskJson[index] = TaskModel(title: updatedTask.title, completed: updatedTask.completed).toJson();
//     await prefs.setString('tasks', json.encode(taskJson));
//   }

//   Future<void> deleteTask(int index) async {
//     final prefs = await SharedPreferences.getInstance();
//     final tasksString = prefs.getString('tasks') ?? '[]';
//     final List<dynamic> taskJson = json.decode(tasksString);
//     taskJson.removeAt(index);
//     await prefs.setString('tasks', json.encode(taskJson));
//   }
// }