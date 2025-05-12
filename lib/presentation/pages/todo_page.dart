import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_bloc/domain/entities/todo.dart';
import 'package:task_bloc/presentation/bloc/todo_bloc.dart';
import 'package:task_bloc/presentation/bloc/todo_event.dart';
import 'package:task_bloc/presentation/bloc/todo_state.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController controller = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedTime;
  String _selectedPriority = 'Medium';
  Todo? _editingTodo;
  String? _selectedColor;
  String? _selectedEmoji;
  List<String> emojis = ['🎯', '💼', '🧘‍♂️', '📚', '💡']; // Emoji list

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ) ?? DateTime.now();
    setState(() {
      _selectedDate = picked;
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
    ) ?? TimeOfDay.now();
    setState(() {
      _selectedTime = picked.format(context);
    });
  }
void _onAddTask() {
  if (controller.text.isNotEmpty) {
    final todo = Todo(
      title: controller.text,
      dueDate: _selectedDate,
      dueTime: _selectedTime,
      priority: _selectedPriority, // Correct priority passed here
    );
    context.read<TodoBloc>().add(AddTodoEvent(todo));
    _clearFields();
    Navigator.pop(context);
  }
}


void _onUpdateTask() {
  if (_editingTodo != null) {
    final updatedTodo = _editingTodo!.copyWith(
      title: controller.text,
      dueDate: _selectedDate,
      dueTime: _selectedTime,
      priority: _selectedPriority, // Ensure priority is updated correctly here
    );
    final todos = (context.read<TodoBloc>().state as TodoLoaded).todos;
    final index = todos.indexOf(_editingTodo!);
    context.read<TodoBloc>().add(UpdateTodoEvent(index, updatedTodo));
    _clearFields();
    Navigator.pop(context);
  }
}

  void _clearFields() {
    controller.clear();
    _selectedDate = null;
    _selectedTime = null;
    _selectedPriority = 'Medium';
    _editingTodo = null;
    _selectedColor = null;
    _selectedEmoji = null;
  }

  void _openEditSheet(Todo todo) {
    controller.text = todo.title;
    _selectedDate = todo.dueDate;
    _selectedTime = todo.dueTime;
    _selectedPriority = todo.priority;
    _editingTodo = todo;
    _showBottomSheet(isEditing: true);
  }

  void _showBottomSheet({bool isEditing = false}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _buildAddSheet(isEditing: isEditing),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return _buildEmptyState(); // Show empty state UI
            }
return ListView.builder(
  controller: _scrollController,
  itemCount: state.todos.length + (_isLoading ? 1 : 0),
  itemBuilder: (context, index) {
    if (index == state.todos.length) {
      return Center(child: CircularProgressIndicator());
    }
    final todo = state.todos[index];

    // Predefined list of emojis
    List<String> emojis = ['🎯', '💼', '🧘‍♂️', '📚', '💡']; // Emoji list
    
    // Select an emoji for the task
    String selectedEmoji = emojis[index % emojis.length];

    // Ensure the priority value is correct (e.g., low, medium, high)
    String priorityText = todo.priority ?? "Medium"; // Default to Medium if it's null

    return Padding(
      padding: const EdgeInsets.only(left:10.0,right:10.0,top:8.0,bottom: 8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Checkbox(
                key: ValueKey<bool>(todo.isCompleted),
                value: todo.isCompleted,
                onChanged: (_) {
                  context.read<TodoBloc>().add(ToggleTodoCompletionEvent(index));
                },
                shape: CircleBorder(),
                activeColor: Colors.green,
                side: BorderSide(color: Colors.green),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Display the emoji next to the task title
                      Text(
                        selectedEmoji,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(width: 8),
                      Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                          color: todo.isCompleted ? Colors.grey : Colors.black,
                        ),
                      ),
                    ],
                  ),
                 SizedBox(height: 8),
      if (todo.dueDate != null)
        Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.green, size: 18),
            
            Text(
              "Due Date: ${DateFormat('yyyy-MM-dd').format(todo.dueDate!)}",
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.blue, size: 18),
            SizedBox(width: 6),
            Text(
              "Due Time: ${todo.dueTime ?? 'No time set'}",
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
          ],
        ),
      ],
        ),
      
                  SizedBox(height: 12),
                  // Correct priority display
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(priorityText), // Updated to use the correct priority
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Priority: $priorityText", // Correctly show priority
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () => _openEditSheet(todo),
                  splashRadius: 25,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  iconSize: 24,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context.read<TodoBloc>().add(DeleteTodoEvent(todo));
                  },
                  splashRadius: 25,
                  iconSize: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  },
);


          } else if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: Text("Something went wrong."));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => _showBottomSheet(),
        child: Icon(Icons.add, size: 30, color: Colors.white),
        elevation: 8,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "No tasks yet!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
            ),
            SizedBox(height: 8),
            Text(
              "Add a task to get started!",
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _showBottomSheet(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              child: Text('Add Task', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
Widget _buildPrioritySelector() {
  return DropdownButton<String>(
    value: _selectedPriority,
    onChanged: (newPriority) {
      setState(() {
        _selectedPriority = newPriority!;
      });
    },
    items: ['Low', 'Medium', 'High']
        .map((priority) => DropdownMenuItem<String>(
              value: priority,
              child: Text(priority),
            ))
        .toList(),
  );
}
Widget _buildPriorityDisplay(String priority) {
  Color priorityColor;

  switch (priority) {
    case 'Low':
      priorityColor = Colors.green;
      break;
    case 'Medium':
      priorityColor = Colors.yellow;
      break;
    case 'High':
      priorityColor = Colors.red;
      break;
    default:
      priorityColor = Colors.grey;
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: priorityColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      "Priority: $priority",
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

  Widget _buildAddSheet({bool isEditing = false}) {
  String localPriority = _selectedPriority; // Use the priority from state
  String localEmoji = _selectedEmoji ?? '💡'; // Default emoji

  return Padding(
    padding: EdgeInsets.only(
      left: 24,
      right: 24,
      top: 20,
      bottom: MediaQuery.of(context).viewInsets.bottom + 24,
    ),
    child: StatefulBuilder(
      builder: (context, setStateSB) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, -10),
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 40,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      isEditing ? 'Edit Task' : 'New Task',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(localEmoji, style: TextStyle(fontSize: 24)),
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: Icon(Icons.task),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: Text(
                          _selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                              : 'Select Date',
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: true,
                        onSelected: (_) async {
                          await _selectDate(context);
                          setStateSB(() {});
                        },
                        selectedColor: Colors.black,
                        backgroundColor: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ChoiceChip(
                        label: Text(
                          _selectedTime ?? 'Select Time',
                          style: TextStyle(color: Colors.white),
                        ),
                        selected: true,
                        onSelected: (_) async {
                          await _selectTime(context);
                          setStateSB(() {});
                        },
                        selectedColor: Colors.black,
                        backgroundColor: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Priority Selection
                Text('Priority', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  children: ['Low', 'Medium', 'High'].map((priority) {
                    return ChoiceChip(
                      label: Text(priority),
                      selected: priority == localPriority,
                      onSelected: (_) {
                        setStateSB(() {
                          localPriority = priority;
                            _selectedPriority = localPriority;  // Update the priority when selected
                        });
                      },
                      selectedColor: _getPriorityColor(priority),
                      backgroundColor: Colors.grey[400],
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Emoji Selection
                Text('Emoji', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  children: emojis.map((emoji) {
                    return ChoiceChip(
                      label: Text(emoji, style: TextStyle(fontSize: 20)),
                      selected: emoji == localEmoji,
                      onSelected: (_) {
                        setStateSB(() {
                          localEmoji = emoji; // Update the emoji when selected
                        });
                      },
                      backgroundColor: Colors.grey[200],
                      selectedColor: Colors.black,
                      checkmarkColor: Colors.white,
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),

                // Save Button
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Update the task when saving
                          if (isEditing) {
                            _onUpdateTask();
                          } else {
                            _onAddTask();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Save Task',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Low':
        return Colors.green;
      default:
        return Colors.orange;
    }
  }
}
