import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_bloc/data/models/task_model.dart';
import 'package:task_bloc/data/datasources/task_local_datasource.dart';
import 'package:task_bloc/domain/entities/task.dart';
import 'package:task_bloc/domain/repositories/task_repository.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<List<Task>> getTasks() async {
    final models = await localDataSource.loadTasks();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    await localDataSource.saveTasks([taskModel]); // Save the task
  }

  @override
  Future<void> removeTask(Task task) async {
    await localDataSource.removeTask(task.id); // Remove task by ID
  }

  @override
  Future<void> toggleTaskStatus(Task task) async {
    task.isCompleted = !task.isCompleted; // Toggle task status
    final updatedTaskModel = TaskModel.fromEntity(task);
    await localDataSource.saveTasks([updatedTaskModel]); // Save the updated task
  }
}
