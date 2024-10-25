import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/data/database/database_helper.dart';
import 'package:task_manager_app/data/models/project_model.dart';
import 'package:task_manager_app/theme/theme_manager.dart';
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

  // Define priority colors
  static const Map<String, Color> priorityColors = {
    'Low': Colors.green,
    'Medium': Colors.yellow,
    'High': Colors.orange,
    'Critical': Colors.red,
  };

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

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 16,
          backgroundColor: isDarkMode
              ? AppTheme.darkCardColor.withOpacity(0.85)
              : AppTheme.cardBackgroundColor.withOpacity(0.85),
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
          title: const Text("Delete Project",
              style: TextStyle(color: Colors.white)),
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
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Project deleted successfully!'),
                    backgroundColor: Colors.red));
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDarkMode ? AppTheme.darkBackgroundColor : AppTheme.backgroundColor,
      body: Column(
        children: [
          const CustomTitleBar(showIcons: false),
          Text(
            'Projects',
            style: TextStyle(
                color:
                    isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Projects...',
                      filled: true,
                      fillColor: isDarkMode
                          ? AppTheme.darkfillcolor
                          : AppTheme.lightfillcolor,
                      hintStyle: TextStyle(
                          color: isDarkMode
                              ? AppTheme.darkTextColor
                              : AppTheme.textColor),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      // Implement search functionality if required
                    },
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedPriority,
                  icon: const Icon(Icons.filter_list),
                  items: ['All', 'Low', 'Medium', 'High', 'Critical']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPriority = newValue!;
                      // Implement filter functionality based on selected priority
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                final project = filteredProjects[index];
                return Card(
                  color: isDarkMode
                      ? AppTheme.darkprjectCardColor.withOpacity(0.85)
                      : AppTheme.lightprjectCardColor.withOpacity(0.85),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: isDarkMode
                            ? AppTheme.darkCardBorderColor
                            : AppTheme.lightCardBorderColor,
                        width: 2), // Use app theme color
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      project.name,
                      style: TextStyle(
                          color: isDarkMode
                              ? AppTheme.darkTextColor
                              : AppTheme.textColor),
                    ),
                    subtitle: Text(
                      project.description,
                      style: TextStyle(
                          color: isDarkMode
                              ? AppTheme.darkTextColor
                              : AppTheme.textColor),
                    ),
                    leading: CircleAvatar(
                      radius: 13,
                      backgroundColor: priorityColors[project.priority],
                      child: Text(
                        project.priority[0], // Show first letter of priority
                        style: const TextStyle(
                            color: Color.fromARGB(255, 22, 22, 22)),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit,
                              color: isDarkMode
                                  ? AppTheme.darkTextColor
                                  : AppTheme.textColor),
                          onPressed: () =>
                              _createOrEditProject(project: project),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete,
                              color: isDarkMode
                                  ? AppTheme.darkTextColor
                                  : AppTheme.textColor),
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
