import '../repositories/todo_repository.dart';
import '../entities/todo.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> call(Todo todo) {
    return repository.deleteTodo(todo);
  }
}
