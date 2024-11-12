import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../data/models/task_model.dart';
import '../../data/models/project_model.dart';
import '../../data/database/database_helper.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: CalendarFormat.month,
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              markersMaxCount: 3,
              markerSize: 8,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList() {
    return FutureBuilder<List<dynamic>>(
      future: _getEventsForSelectedDay(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No events for ${_dateFormat.format(_selectedDay)}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final event = snapshot.data![index];
            if (event is Task) {
              return _buildTaskCard(event);
            } else if (event is Project) {
              return _buildProjectCard(event);
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Widget _buildTaskCard(Task task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          Icons.task_alt,
          color: task.isCompleted ? Colors.green : Colors.orange,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.category),
        trailing: _buildPriorityIndicator(task.priority),
      ),
    );
  }

  Widget _buildProjectCard(Project project) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.folder, color: Colors.blue),
        title: Text(project.name),
        subtitle: Text(project.category),
        trailing: _buildPriorityIndicator(project.priority),
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

  List<dynamic> _getEventsForDay(DateTime day) {
    // This is just for showing markers, actual events are loaded in _getEventsForSelectedDay
    return [''];
  }

  Future<List<dynamic>> _getEventsForSelectedDay() async {
    final List<dynamic> events = [];

    // Get tasks for the selected day
    final tasks = await _databaseHelper.getAllTasks();
    events.addAll(tasks.where((task) {
      final taskDate = DateTime.parse(task.date);
      return isSameDay(taskDate, _selectedDay);
    }));

    // Get projects that overlap with the selected day
    final projects = await _databaseHelper.getAllProjects();
    events.addAll(projects.where((project) {
      final startDate = DateTime.parse(project.startDate);
      final endDate = DateTime.parse(project.lastDate);
      return (_selectedDay.isAfter(startDate) ||
              isSameDay(_selectedDay, startDate)) &&
          (_selectedDay.isBefore(endDate) || isSameDay(_selectedDay, endDate));
    }));

    return events;
  }
}
