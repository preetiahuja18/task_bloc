import 'package:task_bloc/domain/entities/task.dart';

class TaskModel {
  final String id;
  final String title;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  // Convert TaskModel to Task entity
  Task toEntity() {
    return Task(id: id, title: title, isCompleted: isCompleted);
  }

  // Convert Task entity to TaskModel
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
    );
  }

  // Optionally, add toJson and fromJson for data persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }
}
