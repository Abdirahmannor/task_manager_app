import 'package:flutter/material.dart';
import '../../../data/models/project_model.dart'; // Correct import path
import '../../../data/database/database_helper.dart'; // Correct import path

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Project> _projects = [];

  @override
  void initState() {
    super.initState();
    _fetchProjects(); // Fetch projects when the screen initializes
  }

  Future<void> _fetchProjects() async {
    _projects = await _dbHelper
        .getAllProjects(); // Fetch all projects from the database
    setState(() {});
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
      appBar: AppBar(title: const Text('Projects')),
      body: ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_projects[index].name),
            // Add any additional project information as needed
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle adding a new project
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
