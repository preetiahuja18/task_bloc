import '../entities/task.dart';
import '../repositories/task_repository.dart';

class RemoveTask {
  final TaskRepository repository;

  RemoveTask(this.repository);

  Future<void> call(Task task) => repository.removeTask(task);
}
