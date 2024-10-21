import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/database/database_helper.dart';
import '../../../data/models/project_model.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Project> _projects = [];

  @override
  void initState() {
    super.initState();
    _fetchProjects(); // Fetch all projects when the screen initializes
  }

  Future<void> _fetchProjects() async {
    _projects = await _dbHelper
        .getAllProjects(); // Fetch all projects from the database
    setState(() {}); // Refresh the UI
  }

  Future<void> _addProject(String name) async {
    final project = Project(name: name); // Create a new project instance
    await _dbHelper
        .insertProject(project); // Insert new project into the database
    _fetchProjects(); // Refresh the project list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Implement your logic to add a project here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          return ListTile(
            title: Text(project.name),
            // Implement further details or actions as needed
          );
        },
      ),
    );
  }
}