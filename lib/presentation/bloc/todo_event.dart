import 'package:task_bloc/domain/entities/todo.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  AddTodoEvent(this.todo);
}

class UpdateTodoEvent extends TodoEvent {
  final int index;
  final Todo updatedTodo;

  UpdateTodoEvent(this.index, this.updatedTodo);
}

class DeleteTodoEvent extends TodoEvent {
  final Todo todo;

  DeleteTodoEvent(this.todo);
}
class ToggleTodoCompletionEvent extends TodoEvent {
  final int index;

  ToggleTodoCompletionEvent(this.index);
}



class LoadTodosEvent extends TodoEvent {}
