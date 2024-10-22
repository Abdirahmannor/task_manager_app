// import 'package:flutter/material.dart';
// import '../../../theme/app_theme.dart';
// import '../../../utills/project_manager.dart';

// class ProjectCreationScreen extends StatefulWidget {
//   const ProjectCreationScreen({super.key});

//   @override
//   _ProjectCreationScreenState createState() => _ProjectCreationScreenState();
// }

// class _ProjectCreationScreenState extends State<ProjectCreationScreen> {
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final ProjectManager _projectManager = ProjectManager();

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }

//   void _saveProject() {
//     final String title = titleController.text.trim();
//     final String description = descriptionController.text.trim();

//     if (title.isNotEmpty) {
//       final String projectId = DateTime.now().millisecondsSinceEpoch.toString();
//       _projectManager.saveProject(
//         projectId,
//         {
//           'id': projectId,
//           'title': title,
//           'description': description,
//         },
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Project created successfully!'),
//           backgroundColor: AppTheme.sidebarSelectedColor,
//         ),
//       );
//       Navigator.of(context).pop();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Project title cannot be empty.'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Create New Project'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Project Title',
//                 labelStyle: TextStyle(color: AppTheme.textColor),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(
//                 labelText: 'Project Description',
//                 labelStyle: TextStyle(color: AppTheme.textColor),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _saveProject,
//               child: const Text('Create Project'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
