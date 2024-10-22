import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../utills/project_manager.dart';

class ProjectCreationCard extends StatefulWidget {
  final String? projectId;
  final String? initialTitle;
  final String? initialDescription;

  const ProjectCreationCard({
    Key? key,
    this.projectId,
    this.initialTitle,
    this.initialDescription,
  }) : super(key: key);

  @override
  _ProjectCreationCardState createState() => _ProjectCreationCardState();
}

class _ProjectCreationCardState extends State<ProjectCreationCard> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final ProjectManager _projectManager = ProjectManager();

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Project Title',
              labelStyle: TextStyle(color: AppTheme.textColor),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              labelText: 'Project Description',
              labelStyle: TextStyle(color: AppTheme.textColor),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _saveProject,
            child: Text(
                widget.projectId == null ? 'Create Project' : 'Save Changes'),
          ),
        ],
      ),
    );
  }
}
