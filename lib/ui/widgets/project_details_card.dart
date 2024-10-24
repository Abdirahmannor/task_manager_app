import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../theme/app_theme.dart';
import '../../../data/models/project_model.dart'; // Import Project model
import '../../../utills/project_manager.dart';

class ProjectDetailsCard extends StatefulWidget {
  final String? projectId;
  final String? initialTitle;
  final String? initialDescription;
  final String? initialPriority;
  final String? initialStatus;
  final int? initialDuration; // Duration in days
  final DateTime? initialStartDate;
  final Function(String, String, String, String, int, DateTime) onSave;

  const ProjectDetailsCard({
    Key? key,
    this.projectId,
    this.initialTitle,
    this.initialDescription,
    this.initialPriority,
    this.initialStatus,
    this.initialDuration,
    this.initialStartDate,
    required this.onSave,
  }) : super(key: key);

  @override
  _ProjectDetailsCardState createState() => _ProjectDetailsCardState();
}

class _ProjectDetailsCardState extends State<ProjectDetailsCard> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController durationController;

  String _selectedPriority = 'Medium';
  String _selectedStatus = 'Active';
  DateTime? _selectedStartDate;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.initialTitle);
    descriptionController =
        TextEditingController(text: widget.initialDescription);
    durationController =
        TextEditingController(text: widget.initialDuration?.toString());
    _selectedPriority = widget.initialPriority ?? _selectedPriority;
    _selectedStatus = widget.initialStatus ?? _selectedStatus;
    _selectedStartDate = widget.initialStartDate ?? DateTime.now();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    durationController.dispose();
    super.dispose();
  }

  void _saveProject() {
    final String title = titleController.text.trim();
    final String description = descriptionController.text.trim();
    final int duration = int.tryParse(durationController.text.trim()) ?? 0;

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        duration > 0 &&
        _selectedStartDate != null) {
      final String projectId =
          widget.projectId ?? DateTime.now().millisecondsSinceEpoch.toString();
      DateTime lastDate = _selectedStartDate!.add(Duration(days: duration));

      widget.onSave(
        title,
        description,
        _selectedPriority,
        _selectedStatus,
        duration,
        _selectedStartDate!,
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
          content: Text('All fields must be filled out.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
              offset: const Offset(0, 4),
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
                  'Start Date',
                  style: TextStyle(color: AppTheme.textColor),
                ),
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
