import '../entities/task.dart';
import '../repositories/task_repository.dart';

class ToggleTaskStatus {
  final TaskRepository repository;

  ToggleTaskStatus(this.repository);

  Future<void> call(Task task) => repository.toggleTaskStatus(task);
}
