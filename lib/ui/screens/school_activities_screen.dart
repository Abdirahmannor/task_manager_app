import 'package:flutter/material.dart';
import '../../data/database/database_helper.dart';
import '../../data/models/task_model.dart';

class SchoolActivitiesScreen extends StatefulWidget {
  const SchoolActivitiesScreen({super.key});

  @override
  _SchoolActivitiesScreenState createState() => _SchoolActivitiesScreenState();
}

class _SchoolActivitiesScreenState extends State<SchoolActivitiesScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Task> _activities = [];

  @override
  void initState() {
    super.initState();
    _refreshActivities();
  }

  void _refreshActivities() async {
    final activities = await _dbHelper
        .getAllTasks(); // Replace with getSchoolActivities if you create a specific method for school activities
    setState(() {
      _activities = activities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('School Activities'),
      ),
      body: ListView.builder(
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          final activity = _activities[index];
          return ListTile(
            title: Text(activity.title),
            subtitle: Text(activity.description),
          );
        },
      ),
    );
  }
}
