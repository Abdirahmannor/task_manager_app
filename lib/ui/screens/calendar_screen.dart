import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../data/database/database_helper.dart';
import '../../data/models/task_model.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Map<DateTime, List<Task>> _tasksByDate = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _refreshTaskList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: TableCalendar<Task>(
        focusedDay: _focusedDay,
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        calendarFormat: _calendarFormat,
        eventLoader: (day) {
          return _tasksByDate[day] ?? [];
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
