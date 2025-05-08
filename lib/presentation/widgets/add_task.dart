import 'package:flutter/material.dart';
class AddTaskModal extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const AddTaskModal({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery
        .of(context)
        .viewInsets;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final isSmallScreen = width < 360;
    final fontSize = isSmallScreen ? 14.0 : 16.0;
    final padding = isSmallScreen ? 16.0 : 24.0;
    return Padding(
      padding: EdgeInsets.only(
        bottom: viewInsets.bottom,
        top: padding,
        left: padding,
        right: padding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add New Task',
            style: TextStyle(
                fontSize: fontSize + 2, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Task title',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            style: TextStyle(fontSize: fontSize),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onAdd,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                'Add Task',
                style: TextStyle(fontSize: fontSize, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }}