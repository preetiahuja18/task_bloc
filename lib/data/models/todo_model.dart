import 'package:task_bloc/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required String title,
    DateTime? dueDate,
    String? dueTime,
    String priority = 'Medium', // Default priority
    bool isCompleted = false,
  }) : super(
    title: title,
    dueDate: dueDate,
    dueTime: dueTime,
    priority: priority,
    isCompleted: isCompleted,
  );

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'],
      dueDate: DateTime.tryParse(json['dueDate'] ?? ''),
      dueTime: json['dueTime'],
      priority: json['priority'] ?? 'Medium', // Fallback to 'Medium'
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dueDate': dueDate?.toIso8601String(),
      'dueTime': dueTime,
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }
}
