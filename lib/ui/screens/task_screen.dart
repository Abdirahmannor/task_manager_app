import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/database/database_helper.dart';
import 'add_edit_task_screen.dart';
import 'task_detail_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  String _selectedFilter = 'All';
  String _selectedSort = 'Date';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Tasks'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'Upcoming'),
              Tab(text: 'Completed'),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.filter_list),
              onSelected: (value) {
                setState(() {
                  _selectedFilter = value;
                });
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'All', child: Text('All')),
                const PopupMenuItem(value: 'Personal', child: Text('Personal')),
                const PopupMenuItem(value: 'School', child: Text('School')),
                const PopupMenuItem(
                    value: 'Important', child: Text('Important')),
              ],
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildTaskList('today'),
            _buildTaskList('upcoming'),
            _buildTaskList('completed'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddEditTaskScreen(),
              ),
            );
            if (result == true) {
              setState(() {}); // Refresh the task list
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTaskList(String type) {
    return FutureBuilder<List<Task>>(
      future: _databaseHelper.getAllTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.task_alt, size: 70, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No tasks yet',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          );
        }

        final tasks = _filterTasks(snapshot.data!, type);

        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.filter_list, size: 70, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'No tasks match the filter',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(tasks[index].id.toString()),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _deleteTask(tasks[index]);
              },
              child: _buildTaskCard(tasks[index]),
            );
          },
        );
      },
    );
  }

  Widget _buildTaskCard(Task task) {
    return GestureDetector(
      onTap: () => _onTaskTap(task),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (bool? value) async {
              if (value != null) {
                await _databaseHelper.updateTaskCompletion(task.id, value);
                setState(() {}); // Refresh the list
              }
            },
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(task.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPriorityIndicator(task.priority),
              const SizedBox(width: 8),
              _buildCategoryChip(task.category),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityIndicator(String priority) {
    Color color;
    switch (priority.toLowerCase()) {
      case 'high':
        color = Colors.red;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      default:
        color = Colors.green;
    }
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.blue,
        ),
      ),
    );
  }

  List<Task> _filterTasks(List<Task> tasks, String type) {
    var filteredTasks = tasks;

    // Filter by category if not 'All'
    if (_selectedFilter != 'All') {
      filteredTasks = filteredTasks
          .where((task) => task.category == _selectedFilter)
          .toList();
    }

    // Filter by type (today, upcoming, completed)
    switch (type) {
      case 'today':
        final today = DateTime.now();
        filteredTasks = filteredTasks.where((task) {
          final taskDate = DateTime.parse(task.date);
          return !task.isCompleted &&
              taskDate.year == today.year &&
              taskDate.month == today.month &&
              taskDate.day == today.day;
        }).toList();
        break;
      case 'upcoming':
        final today = DateTime.now();
        filteredTasks = filteredTasks.where((task) {
          final taskDate = DateTime.parse(task.date);
          return !task.isCompleted && taskDate.isAfter(today);
        }).toList();
        break;
      case 'completed':
        filteredTasks =
            filteredTasks.where((task) => task.isCompleted).toList();
        break;
    }

    return filteredTasks;
  }

  void _onTaskTap(Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(task: task),
      ),
    );
    if (result == true) {
      setState(() {}); // Refresh the task list
    }
  }

  void _deleteTask(Task task) async {
    await _databaseHelper.deleteTask(task.id);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task "${task.title}" deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            await _databaseHelper.insertTask(task);
            setState(() {});
          },
        ),
      ),
    );
  }
}
