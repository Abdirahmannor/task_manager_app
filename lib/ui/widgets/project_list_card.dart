import 'package:flutter/material.dart';
import '../../../data/models/project_model.dart';
import '../../../theme/app_theme.dart';

class ProjectListCard extends StatelessWidget {
  final Project project;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProjectListCard({
    Key? key,
    required this.project,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isDarkMode
              ? AppTheme.darkCardBorderColor
              : AppTheme.lightCardBorderColor,
        ), // Use app theme color
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          project.name,
          style: TextStyle(
            color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
          ),
        ),
        subtitle: Text(
          project.description,
          style: TextStyle(
              color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
