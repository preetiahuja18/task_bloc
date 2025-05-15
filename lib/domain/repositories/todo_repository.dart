import 'package:task_bloc/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<void> addTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
  Future<void> updateTodo(int index, Todo todo); 
  Future<List<Todo>> getTodos();
}
