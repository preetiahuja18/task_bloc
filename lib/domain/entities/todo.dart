class Todo {
  final String title;
  final DateTime? dueDate;
  final String? dueTime;
  final String priority;
  final bool isCompleted;

  Todo({
    required this.title,
    this.dueDate,
    this.dueTime,
     this.priority = 'Medium',
    this.isCompleted = false,
  });


 Todo copyWith({
  String? title,
  DateTime? dueDate,
  String? dueTime,
  String? priority,
  bool? isCompleted,
}) {
  return Todo(
    title: title ?? this.title,
    dueDate: dueDate ?? this.dueDate,
    dueTime: dueTime ?? this.dueTime,
    priority: priority ?? this.priority,
    isCompleted: isCompleted ?? this.isCompleted,
  );
}
}
