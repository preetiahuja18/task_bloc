// todo_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_bloc/domain/entities/todo.dart';
import 'package:task_bloc/domain/repositories/todo_repository.dart';
import 'package:task_bloc/presentation/bloc/todo_event.dart';
import 'package:task_bloc/presentation/bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  List<Todo> todos = [];

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<LoadTodosEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        todos = await todoRepository.getTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        print("Error loading todos: $e");
        emit(TodoError("Failed to load tasks"));
      }
    });

  on<AddTodoEvent>((event, emit) async {
  try {
    await todoRepository.addTodo(event.todo);
    todos = await todoRepository.getTodos(); // ✅ Refresh after adding
    emit(TodoLoaded(List.from(todos))); // ✅ New state emitted
  } catch (e) {
    emit(TodoError("Failed to add task"));
  }
});



  on<UpdateTodoEvent>((event, emit) async {
  try {
    await todoRepository.updateTodo(event.index, event.updatedTodo);
    todos = await todoRepository.getTodos(); // Fetch updated list after updating
    emit(TodoLoaded(List.from(todos)));
  } catch (e) {
    print("Error updating todo: $e");
    emit(TodoError("Failed to update task"));
  }
});

    on<DeleteTodoEvent>((event, emit) async {
      try {
        await todoRepository.deleteTodo(event.todo);
        todos = await todoRepository.getTodos(); // Fetch updated list after deleting
        emit(TodoLoaded(List.from(todos)));
      } catch (e) {
        print("Error deleting todo: $e");
        emit(TodoError("Failed to delete task"));
      }
    });

   on<ToggleTodoCompletionEvent>((event, emit) async {
  try {
    final updatedTodo = todos[event.index].copyWith(
      isCompleted: !todos[event.index].isCompleted,
    );

    // Update in repository
    await todoRepository.updateTodo(event.index, updatedTodo);

    // Update in local list immutably
    todos[event.index] = updatedTodo;

    // Emit updated state with a new list reference
    emit(TodoLoaded(List.from(todos)));
  } catch (e) {
    print("Error toggling completion: $e");
    emit(TodoError("Failed to toggle task completion"));
  }
});

  }
}
