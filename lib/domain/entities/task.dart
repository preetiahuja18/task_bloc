enum TaskPriority { Low, Medium, High }

class Task {
  final String title;
  final bool completed;
  final DateTime dueDate;
  final TaskPriority priority;

  Task({
    required this.title,
    required this.completed,
    required this.dueDate,
    required this.priority,
  });
}
