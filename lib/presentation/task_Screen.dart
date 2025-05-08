// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:confetti/confetti.dart';
// import 'package:task_bloc/presentation/widgets/add_task.dart';
// import 'package:task_bloc/presentation/widgets/empty_State.dart';

// import 'package:task_bloc/presentation/widgets/task_tile.dart';
// import '../../domain/entities/task.dart';
// import '../bloc/task_bloc.dart';
// import '../bloc/task_event.dart';
// import '../bloc/task_state.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
//   late List<Task> _currentTasks;
//   late ConfettiController _confettiController;

//   @override
//   void initState() {
//     super.initState();
//     _currentTasks = [];
//     _confettiController = ConfettiController(duration: const Duration(seconds: 1));
//     context.read<TaskBloc>().add(LoadTasksEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F7F7),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text(
//           'Task Manager',
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.w600,
//             fontFamily: 'Poppins',
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final screenWidth = constraints.maxWidth;
//           final horizontalPadding = screenWidth * 0.05;
//           return BlocConsumer<TaskBloc, TaskState>(
//             listener: (context, state) {
//               if (state is TaskLoadedState) {
//                 final newTasks = state.tasks;
//                 if (newTasks.length > _currentTasks.length) {
//                   final newIndex = newTasks.length - 1;
//                   _listKey.currentState?.insertItem(newIndex);
//                 }
//                 _currentTasks = List.from(newTasks);
//               }
//             },
//             builder: (context, state) {
//               if (state is TaskLoadingState) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is TaskLoadedState) {
//                 if (state.tasks.isEmpty) {
//                   return EmptyState(onAddPressed: () => showAddTaskModal(context));
//                 }
//                 return AnimatedList(
//                   key: _listKey,
//                   padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 10),
//                   initialItemCount: state.tasks.length,
//                   itemBuilder: (context, index, animation) {
//                     return SizeTransition(
//                       sizeFactor: animation,
//                       child: TaskTile(
//                         task: state.tasks[index],
//                         index: index,
//                         onToggle: () {
//                           context.read<TaskBloc>().add(ToggleTaskEvent(index));
//                           _confettiController.play();
//                         },
//                         onDelete: () => _deleteTask(index),
//                       ),
//                     );
//                   },
//                 );
//               } else if (state is TaskErrorState) {
//                 return Center(child: Text(state.message));
//               }
//               return const SizedBox();
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.black,
//         child: const Icon(Icons.add, size: 30, color: Colors.white),
//         onPressed: () => showAddTaskModal(context),
//       ),
//     );
//   }

//   void showAddTaskModal(BuildContext parentContext) {
//     final TextEditingController controller = TextEditingController();
//     DateTime selectedDate = DateTime.now();
//     TaskPriority selectedPriority = TaskPriority.Medium;
//     showModalBottomSheet(
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//       ),
//       context: parentContext,
//       builder: (BuildContext context) {
//         return BlocProvider.value(
//           value: BlocProvider.of<TaskBloc>(parentContext),
//           child: AddTaskModal(
//             controller: controller,
//             onAdd: () {
//               final text = controller.text.trim();
//               if (text.isNotEmpty) {
//                 parentContext.read<TaskBloc>().add(AddTaskEvent(text, selectedDate, selectedPriority));
//                 Navigator.of(context).pop();
//               }
//             },
//             onDueDateSelected: (dueDate) => selectedDate = dueDate,
//             onPrioritySelected: (priority) => selectedPriority = priority,
//           ),
//         );
//       },
//     );
//   }


//   void _deleteTask(int index) {
//     final removedTask = _currentTasks[index];
//     context.read<TaskBloc>().add(DeleteTaskEvent(index));
//     _listKey.currentState?.removeItem(
//         index,
//     (context, animation) => SizeTransition(
//       sizeFactor: animation,
//       child: TaskTile(
//         task: removedTask,
//         index: index,
//         onToggle: () {},
//         onDelete: () {},
//       ),
//     ),
//     duration
// : const Duration(milliseconds: 300),
// );
// }
// }