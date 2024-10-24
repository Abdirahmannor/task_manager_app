import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/database/database_helper.dart';
import '../../data/models/task_model.dart';
import '../../data/models/project_model.dart'; // Import the Project model

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Map<DateTime, List<Task>> _tasksByDate = {};
  Map<DateTime, List<Project>> _projectsByDate = {}; // For projects
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
    _refreshProjectList(); // New method for projects
  }

  void _refreshTaskList() async {
    final tasks = await _dbHelper.getAllTasks();
    setState(() {
      _tasksByDate = {};
      for (var task in tasks) {
        final date = DateTime.parse(task.date);
        if (_tasksByDate[date] == null) {
          _tasksByDate[date] = [];
        }
        _tasksByDate[date]!.add(task);
      }
    });
  }

  void _refreshProjectList() async {
    final projects = await _dbHelper.getAllProjects(); // Fetch projects
    setState(() {
      _projectsByDate = {};
      for (var project in projects) {
        final startDate = project.startDate; // Use the DateTime object directly
        final lastDate = project.lastDate; // Use the DateTime object directly
        for (DateTime date = startDate;
            date.isBefore(lastDate) || date.isAtSameMomentAs(lastDate);
            date = date.add(Duration(days: 1))) {
          if (_projectsByDate[date] == null) {
            _projectsByDate[date] = [];
          }
          _projectsByDate[date]!
              .add(project); // Add project to the corresponding date
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: TableCalendar<dynamic>(
        // Change List<Task> to List<dynamic>
        focusedDay: _focusedDay,
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        calendarFormat: _calendarFormat,
        eventLoader: (day) {
          // Combine tasks and projects for display on the calendar
          final tasks = _tasksByDate[day] ?? [];
          final projects = _projectsByDate[day] ?? [];
          return [...tasks, ...projects]; // Combine tasks and projects
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
            _calendarFormat = CalendarFormat.week;
          });
        },
      ),
    );
  }
}
