import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../../../theme/app_theme.dart';
import '../../../utills/project_manager.dart';

class ProjectCreationCard extends StatefulWidget {
  final String? projectId;
  final String? initialTitle;
  final String? initialDescription;
  final Function(String, String) onSave; // onSave callback

  const ProjectCreationCard({
    Key? key,
    this.projectId,
    this.initialTitle,
    this.initialDescription,
    required this.onSave, // Required callback
  }) : super(key: key);

  @override
  _ProjectCreationCardState createState() => _ProjectCreationCardState();
}

class _ProjectCreationCardState extends State<ProjectCreationCard> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final ProjectManager _projectManager = ProjectManager();
  String _selectedPriority = 'Medium'; // Default priority
  String _selectedStatus = 'Active'; // Default status
  DateTime? _selectedDeadline; // Holds selected date

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle);
    descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _saveProject() {
    final String title = titleController.text.trim();
    final String description = descriptionController.text.trim();

    if (title.isNotEmpty) {
      final String projectId =
          widget.projectId ?? DateTime.now().millisecondsSinceEpoch.toString();
      _projectManager.saveProject(
        projectId,
        {
          'id': projectId,
          'title': title,
          'description': description,
          'priority': _selectedPriority,
          'status': _selectedStatus,
          'deadline': _selectedDeadline?.toIso8601String() ?? '',
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.projectId == null
              ? 'Project created successfully!'
              : 'Project updated successfully!'),
          backgroundColor: AppTheme.sidebarSelectedColor,
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
  }

  Future<void> _selectDeadline() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDeadline = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 16,
      backgroundColor: Colors.white.withOpacity(0.95),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
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
              const Divider(),
              const SizedBox(height: 8),
              const Text(
                "Project Settings",
                style: TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
                  prefixIcon: Icon(Icons.task_alt, color: AppTheme.textColor),
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
                title: const Text(
                  'Deadline',
                  style: TextStyle(color: AppTheme.textColor),
                ),
                subtitle: Text(
                  _selectedDeadline == null
                      ? 'No deadline selected'
                      : DateFormat.yMMMd().format(_selectedDeadline!),
                  style: const TextStyle(color: AppTheme.textColor),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectDeadline,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProject,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(widget.projectId == null
                      ? 'Create Project'
                      : 'Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
