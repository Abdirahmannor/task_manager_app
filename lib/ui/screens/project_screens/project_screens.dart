import 'package:flutter/material.dart';

import '../../../data/database/database_helper.dart';
import '../../../data/models/project_model.dart';
import '../../widgets/custom_title_bar.dart';

// Import your custom title bar

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
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    _projects = await _dbHelper.getAllProjects();
    setState(() {});
  }

  Future<void> _addProject(String name) async {
    final project = Project(name: name);
    await _dbHelper.insertProject(project);
    _fetchProjects();
  }

  void _showCreateProjectDialog() {
    final TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Project'),
          content: TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Project Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addProject(titleController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTitleBar(showIcons: true), // Custom title bar
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _projects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_projects[index].name),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: _showCreateProjectDialog,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
