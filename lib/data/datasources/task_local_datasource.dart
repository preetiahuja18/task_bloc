import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_bloc/data/models/task_model.dart';
import 'package:task_bloc/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> loadTasks();
  Future<void> saveTasks(List<TaskModel> tasks);
  Future<void> removeTask(String taskId);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  static const _kTasksKey = 'tasks';

  @override
  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_kTasksKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => TaskModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(tasks.map((e) => e.toJson()).toList());
    await prefs.setString(_kTasksKey, jsonString);
  }

  // Add removeTask method to remove a task by its ID
  Future<void> removeTask(String taskId) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_kTasksKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      // Remove task by ID
      decoded.removeWhere((task) => task['id'] == taskId);
      // Save the updated list back to SharedPreferences
      await prefs.setString(_kTasksKey, jsonEncode(decoded));
    }
  }
}
