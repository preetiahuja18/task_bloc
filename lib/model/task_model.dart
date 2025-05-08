import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class TaskModel extends Task {
  TaskModel({
    required String title,
    required bool completed,
    required DateTime dueDate,
    required TaskPriority priority,
  }) : super(
          title: title,
          completed: completed,
          dueDate: dueDate,
          priority: priority,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      completed: json['completed'],
      dueDate: DateTime.parse(json['dueDate']),
      priority: TaskPriority.values[json['priority']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority.index,
    };
  }
}
