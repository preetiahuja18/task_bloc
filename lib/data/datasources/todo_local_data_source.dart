import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

class TodoLocalDataSource {
  Future<void> saveTodos(List<TodoModel> todos) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = todos.map((todo) => todo.toJson()).toList();
      await prefs.setString('todos', jsonEncode(jsonList));
    } catch (e) {
      print('Error saving todos: $e');
      rethrow; // or throw a custom exception
    }
  }

  Future<List<TodoModel>> getTodos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('todos');
      if (jsonString != null) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => TodoModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print('Error loading todos: $e');
      return [];
    }
  }
}
