import 'package:flutter/material.dart';
import 'package:task_manager_app/data/database/database_helper.dart';
import 'package:task_manager_app/data/models/project_model.dart';
import 'package:task_manager_app/ui/widgets/custom_title_bar.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_theme.dart';

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

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController durationController;

  String _selectedPriority = 'Medium';
  String _selectedStatus = 'Active';
  DateTime? _selectedStartDate;

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
    titleController = TextEditingController(text: project?.name);
    descriptionController = TextEditingController(text: project?.description);
    durationController =
        TextEditingController(text: project?.duration?.toString());

    _selectedPriority = project?.priority ?? 'Medium';
    _selectedStatus = project?.status ?? 'Active';
    _selectedStartDate = project?.startDate ?? DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 16,
          backgroundColor: Colors.white.withOpacity(0.95),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Project Information",
                    style: TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Project Title',
                      prefixIcon: Icon(Icons.title, color: AppTheme.textColor),
                      labelStyle: TextStyle(color: AppTheme.textColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Project Description',
                      prefixIcon:
                          Icon(Icons.description, color: AppTheme.textColor),
                      labelStyle: TextStyle(color: AppTheme.textColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Duration (days)',
                      prefixIcon: Icon(Icons.timer, color: AppTheme.textColor),
                      labelStyle: TextStyle(color: AppTheme.textColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedPriority,
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      prefixIcon:
                          Icon(Icons.priority_high, color: AppTheme.textColor),
                      labelStyle: TextStyle(color: AppTheme.textColor),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPriority = newValue!;
                      });
                    },
                    items: ['Low', 'Medium', 'High', 'Critical']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      prefixIcon:
                          Icon(Icons.task_alt, color: AppTheme.textColor),
                      labelStyle: TextStyle(color: AppTheme.textColor),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedStatus = newValue!;
                      });
                    },
                    items: ['Active', 'On Hold', 'Completed', 'Overdue']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Start Date',
                        style: TextStyle(color: AppTheme.textColor)),
                    subtitle: Text(
                      _selectedStartDate == null
                          ? 'No start date selected'
                          : DateFormat.yMMMd().format(_selectedStartDate!),
                      style: const TextStyle(color: AppTheme.textColor),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _selectStartDate,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _saveProject(project);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                          project == null ? 'Create Project' : 'Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectStartDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedStartDate = pickedDate;
      });
    }
  }

  void _saveProject(Project? project) {
    final String title = titleController.text.trim();
    final String description = descriptionController.text.trim();
    final int duration = int.tryParse(durationController.text.trim()) ?? 0;

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        duration > 0 &&
        _selectedStartDate != null) {
      final DateTime lastDate =
          _selectedStartDate!.add(Duration(days: duration));

      // Create or update the project
      Project newProject = Project(
        id: project?.id, // Maintain the same ID if editing
        name: title,
        description: description,
        priority: _selectedPriority,
        status: _selectedStatus,
        duration: duration,
        startDate: _selectedStartDate!,
        lastDate: lastDate,
      );

      if (project == null) {
        // Insert new project
        _projectManager.insertProject(newProject);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Project created successfully!')));
      } else {
        // Update existing project
        _projectManager.updateProject(newProject);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Project updated successfully!')));
      }

      _refreshProjectList(); // Refresh the project list
      Navigator.of(context).pop(); // Close the dialog
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('All fields must be filled out.'),
          backgroundColor: Colors.red));
    }
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
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search Projects...',
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) {
              // Implement search functionality if required
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
