import 'package:task_bloc/domain/entities/todo.dart';
import 'package:task_bloc/domain/repositories/todo_repository.dart';

class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<void> call(int index, Todo updatedTodo) async {
    await repository.updateTodo(index, updatedTodo);
  }
}
