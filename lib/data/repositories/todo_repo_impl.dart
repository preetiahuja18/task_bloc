import 'package:task_bloc/data/datasources/todo_local_data_source.dart';
import 'package:task_bloc/data/models/todo_model.dart';
import 'package:task_bloc/domain/entities/todo.dart';
import 'package:task_bloc/domain/repositories/todo_repository.dart';

class TodoRepoImpl implements TodoRepository {
  final TodoLocalDataSource dataSource;
  List<TodoModel> _cache = [];

  TodoRepoImpl(this.dataSource);

  // Convert Todo to TodoModel before adding
  @override
  Future<void> addTodo(Todo todo) async {
    try {
      _cache.add(TodoModel(
        title: todo.title,
        dueDate: todo.dueDate,
        dueTime: todo.dueTime,
        priority: todo.priority,
      ));
      await dataSource.saveTodos(_cache);
    } catch (e) {
      print('Error adding todo: $e');
      rethrow;
    }
  }

  // Convert Todo to TodoModel before deleting
  @override
  Future<void> deleteTodo(Todo todo) async {
    try {
      _cache.removeWhere((element) => element.title == todo.title);
      await dataSource.saveTodos(_cache);
    } catch (e) {
      print('Error deleting todo: $e');
      rethrow;
    }
  }

  // Convert Todo to TodoModel before updating
  @override
  Future<void> updateTodo(int index, Todo updatedTodo) async {
    try {
      if (index >= 0 && index < _cache.length) {
       _cache[index] = TodoModel(
  title: updatedTodo.title,
  dueDate: updatedTodo.dueDate,
  dueTime: updatedTodo.dueTime,
  priority: updatedTodo.priority,
  isCompleted: updatedTodo.isCompleted,
);

        await dataSource.saveTodos(_cache);
      } else {
        print('Invalid index for updating todo');
      }
    } catch (e) {
      print('Error updating todo: $e');
      rethrow;
    }
  }

  // Convert TodoModel to Todo when fetching data
  @override
  Future<List<Todo>> getTodos() async {
    try {
      _cache = await dataSource.getTodos();
      // Map TodoModel to Todo before returning
      return _cache.map((todoModel) => Todo(
        title: todoModel.title,
        dueDate: todoModel.dueDate,
        dueTime: todoModel.dueTime,
        priority: todoModel.priority,
      )).toList();
    } catch (e) {
      print('Error fetching todos: $e');
      return [];
    }
  }
}
