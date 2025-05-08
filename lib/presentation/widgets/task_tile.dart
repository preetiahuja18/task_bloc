
import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int index;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.index,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final isSmallScreen = width < 360;
    final titleFontSize = isSmallScreen ? 14.0 : 16.0;
    final iconSize = isSmallScreen ? 20.0 : 24.0;
    final tilePadding = isSmallScreen ? 10.0 : 16.0;
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: tilePadding, vertical: 12),
        child: Row(
          children: [
            Checkbox(
              value: task.completed,
              onChanged: (_) => onToggle(),
            ),
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  decoration: task.completed
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, size: iconSize,
                  color: Colors.redAccent),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }}