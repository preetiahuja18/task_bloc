// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../domain/entities/task.dart';

// class AddTaskModal extends StatelessWidget {
//   final TextEditingController controller;
//   final VoidCallback onAdd;
//   final ValueChanged<DateTime> onDueDateSelected;
//   final ValueChanged<TaskPriority> onPrioritySelected;

//   const AddTaskModal({
//     super.key,
//     required this.controller,
//     required this.onAdd,
//     required this.onDueDateSelected,
//     required this.onPrioritySelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final viewInsets = MediaQuery.of(context).viewInsets;
//     final width = MediaQuery.of(context).size.width;
//     final isSmallScreen = width < 360;
//     final fontSize = isSmallScreen ? 14.0 : 16.0;
//     final padding = isSmallScreen ? 16.0 : 24.0;

//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: viewInsets.bottom,
//         top: padding,
//         left: padding,
//         right: padding,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Add New Task',
//             style: TextStyle(fontSize: fontSize + 2, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 12),
//           TextField(
//             controller: controller,
//             decoration: InputDecoration(
//               labelText: 'Task title',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             style: TextStyle(fontSize: fontSize),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () => _pickDueDate(context),
//             child: const Text('Pick Due Date'),
//           ),
//           const SizedBox(height: 12),
//           DropdownButton<TaskPriority>(
//             onChanged: onPrioritySelected,
//             items: TaskPriority.values.map((priority) {
//               return DropdownMenuItem<TaskPriority>(
//                 value: priority,
//                 child: Text(priority.toString().split('.').last),
//               );
//             }).toList(),
//             hint: const Text('Select Task Priority'),
//           ),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: onAdd,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//             ),
//             child: Text(
//               'Add Task',
//               style: TextStyle(fontSize: fontSize, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _pickDueDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       final TimeOfDay? timePicked = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.fromDateTime(DateTime.now()),
//       );
//       if (timePicked != null) {
//         final DateTime dueDate = DateTime(
//           picked.year,
//           picked.month,
//           picked.day,
//           timePicked.hour,
//           timePicked.minute,
//         );
//         onDueDateSelected(dueDate);
//       }
//     }
//   }
// }
