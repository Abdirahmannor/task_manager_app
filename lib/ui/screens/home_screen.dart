import 'package:flutter/material.dart';
import '../../utills/project_manager.dart'; // Import ProjectManager
import '../widgets/custom_title_bar.dart'; // Import your custom title bar
import '../widgets/sidebar_drawer.dart'; // Import SidebarDrawer
import '../../theme/app_theme.dart'; // Import AppTheme for colors

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProjectManager _projectManager = ProjectManager();
  late List<Map<String, dynamic>> userProjects;
  String selectedPage = 'Dashboard'; // Default page

  @override
  void initState() {
    super.initState();
    userProjects = _projectManager.getAllProjects();
    for (var project in userProjects) {
      if (project['id'] == null || project['id'] == 'Unknown ID') {
        project['id'] = DateTime.now().millisecondsSinceEpoch.toString();
        _projectManager.saveProject(project['id'], project);
      }
    }
  }

  void _createNewProject() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController titleController = TextEditingController();
        final TextEditingController descriptionController =
            TextEditingController();

        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor, // Use theme color
          title: const Text(
            "Create New Project",
            style: TextStyle(color: AppTheme.textColor), // Use theme color
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Project Title",
                  labelStyle:
                      TextStyle(color: AppTheme.textColor), // Use theme color
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: "Project Description",
                  labelStyle:
                      TextStyle(color: AppTheme.textColor), // Use theme color
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final String title = titleController.text.trim();
                final String description = descriptionController.text.trim();

                if (title.isNotEmpty) {
                  final String projectId =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  _projectManager.saveProject(
                    projectId,
                    {
                      'id': projectId,
                      'title': title,
                      'description': description,
                    },
                  );
                  setState(() {
                    userProjects = _projectManager.getAllProjects();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Project created successfully!'),
                      backgroundColor:
                          AppTheme.sidebarSelectedColor, // Use theme color
                    ),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Project title cannot be empty.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Create"),
            ),
          ],
        );
      },
    );
  }

  void _editProject(String projectId) {
    final project = _projectManager.getProject(projectId);

    if (project != null) {
      final TextEditingController titleController =
          TextEditingController(text: project['title']);
      final TextEditingController descriptionController =
          TextEditingController(text: project['description']);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).cardColor, // Use theme color
            title: const Text(
              "Edit Project",
              style: TextStyle(color: AppTheme.textColor), // Use theme color
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Project Title",
                    labelStyle:
                        TextStyle(color: AppTheme.textColor), // Use theme color
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Project Description",
                    labelStyle:
                        TextStyle(color: AppTheme.textColor), // Use theme color
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  final String updatedTitle = titleController.text.trim();
                  final String updatedDescription =
                      descriptionController.text.trim();

                  if (updatedTitle.isNotEmpty) {
                    _projectManager.saveProject(
                      projectId,
                      {
                        'id': projectId,
                        'title': updatedTitle,
                        'description': updatedDescription,
                      },
                    );
                    setState(() {
                      userProjects = _projectManager.getAllProjects();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Project updated successfully!'),
                        backgroundColor:
                            AppTheme.sidebarSelectedColor, // Use theme color
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Project title cannot be empty.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text("Save"),
              ),
            ],
          );
        },
      );
    }
  }

  void _deleteProject(String projectId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor, // Use theme color
          title: const Text("Delete Project"),
          content: const Text("Are you sure you want to delete this project?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _projectManager.deleteProject(projectId);
                setState(() {
                  userProjects = _projectManager.getAllProjects();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Project deleted successfully!'),
                    backgroundColor:
                        AppTheme.sidebarSelectedColor, // Use theme color
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void onSidebarPageSelected(String page) {
    setState(() {
      selectedPage = page;
    });
  }

  Widget _buildContentArea() {
    switch (selectedPage) {
      case 'Dashboard':
        return _buildProjectList();
      case 'School Activities':
        return const Center(child: Text('School Activities Content'));
      case 'Calendar':
        return const Center(child: Text('Calendar Content'));
      case 'Favorites':
        return const Center(child: Text('Favorites Content'));
      case 'Notes':
        return const Center(child: Text('Notes Content'));
      default:
        return const Center(child: Text('Select a page'));
    }
  }

  Widget _buildProjectList() {
    return userProjects.isEmpty
        ? const Center(
            child: Text(
              'No projects found. Start by creating a new project!',
              style: TextStyle(
                fontSize: 18,
                color: AppTheme.textColor, // Use the theme color for text
              ),
            ),
          )
        : ListView.builder(
            itemCount: userProjects.length,
            itemBuilder: (context, index) {
              final project = userProjects[index];
              final projectId = project['id'] ?? 'Unknown ID';
              return Card(
                color: Theme.of(context)
                    .cardColor, // Adapt card color based on the theme
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    project['title'] ?? 'Unnamed Project',
                    style: const TextStyle(
                        color: AppTheme.textColor), // Use theme color
                  ),
                  subtitle: Text(
                    'ID: $projectId\n${project['description'] ?? 'No description available'}',
                    style: const TextStyle(
                        color: AppTheme.textColor), // Use theme color
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editProject(projectId),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteProject(projectId),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarDrawer(onPageSelected: onSidebarPageSelected),
          Expanded(
            child: Column(
              children: [
                const CustomTitleBar(
                    showIcons: true), // Custom title bar at the top
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildContentArea(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: selectedPage == 'Dashboard'
          ? FloatingActionButton(
              backgroundColor: AppTheme.buttonColor, // Use theme color
              onPressed: _createNewProject,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
