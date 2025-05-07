import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../../domain/entities/task.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Manager')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final tasks = state.tasks;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (_, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          context.read<TaskBloc>().add(ToggleTaskStatusEvent(task));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TaskBloc>().add(RemoveTaskEvent(task));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No tasks found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final task = Task(id: '1', title: 'New Task', isCompleted: false);
          context.read<TaskBloc>().add(AddTaskEvent(task));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
