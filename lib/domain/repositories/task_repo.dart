
import '../entities/task.dart';

abstract class TaskRepository {
  Future<void> addTask(String title);
  Future<void> toggleTask(int index);
  Future<void> deleteTask(int index);
  Future<List<Task>> getTasks();
}
