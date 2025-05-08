// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../data/task.repository.dart';
// import '../../domain/entities/task.dart';
// import '../../model/task_model.dart';


// class TaskRepositoryImpl implements TaskRepository {
//   static const _key = 'TASKS';

//   Future<List<TaskModel>> _loadFromPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString(_key);
//     if (jsonString == null) return [];
//     final List decoded = json.decode(jsonString);
//     return decoded.map((e) => TaskModel.fromJson(e)).toList();
//   }

//   Future<void> _saveToPrefs(List<TaskModel> tasks) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(_key, json.encode(tasks.map((e) => e.toJson()).toList()));
//   }

//   @override
//   Future<void> addTask(String title) async {
//     final tasks = await _loadFromPrefs();
//     tasks.add(TaskModel(title: title, completed: false));
//     await _saveToPrefs(tasks);
//   }

//   @override
//   Future<void> deleteTask(int index) async {
//     final tasks = await _loadFromPrefs();
//     tasks.removeAt(index);
//     await _saveToPrefs(tasks);
//   }

//   @override
//   Future<void> toggleTask(int index) async {
//     final tasks = await _loadFromPrefs();
//     final task = tasks[index];
//     tasks[index] = TaskModel(title: task.title,completed: !task.completed);
//     await _saveToPrefs(tasks);
//   }

//   @override
//   Future<List<Task>> getTasks() async {
//     return _loadFromPrefs();
//   }
// }