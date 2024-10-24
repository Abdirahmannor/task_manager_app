import 'package:flutter/material.dart';
import 'package:task_manager_app/data/database/database_helper.dart';
import 'package:task_manager_app/data/models/project_model.dart';
import 'package:task_manager_app/ui/widgets/project_details_card.dart'; // Updated to ProjectDetailsCard
import 'package:task_manager_app/ui/widgets/custom_title_bar.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final DatabaseHelper _projectManager = DatabaseHelper();
  late List<Project> userProjects;
  List<Project> filteredProjects = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshProjectList();
  }

  void _refreshProjectList() async {
    userProjects = await _projectManager.getAllProjects();
    setState(() {
      filteredProjects = List.from(userProjects);
    });
  }

  void _createOrEditProject({Project? project}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProjectDetailsCard(
          projectId: project?.id?.toString(),
          initialTitle: project?.name,
          initialDescription: project?.description,
          initialPriority: project?.priority,
          initialStatus: project?.status,
          initialDuration: project?.duration,
          initialStartDate: project?.startDate,
          onSave: (title, description, priority, status, duration, startDate) {
            // Create or update the project object
            Project updatedProject = Project(
              id: project?.id,
              name: title,
              description: description,
              priority: priority,
              status: status,
              duration: duration,
              startDate: startDate,
              lastDate: startDate.add(Duration(days: duration)),
            );

            // Insert new project or update existing project
            if (project == null) {
              _projectManager.insertProject(updatedProject);
            } else {
              _projectManager.updateProject(updatedProject);
            }

            // Refresh the project list
            _refreshProjectList(); // Make sure this updates the UI

            // Close the dialog after the project list has been refreshed
            Navigator.of(context).pop();
            _refreshProjectList();
          },
        );
      },
    );
  }

  void _deleteProject(Project project) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Project"),
          content: const Text("Are you sure you want to delete this project?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog without deleting
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _projectManager.deleteProject(project.id);
                _refreshProjectList(); // Refresh the project list
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: Column(
        children: [
          // Search functionality
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search Projects...',
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                // Implement search functionality if required
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                final project = filteredProjects[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(project.name),
                    subtitle: Text(project.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () =>
                              _createOrEditProject(project: project),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteProject(project),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () => _createOrEditProject(),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
