import 'package:task_bloc/domain/entities/task.dart' show Task;
import 'package:task_bloc/domain/repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() => repository.getTasks();
}