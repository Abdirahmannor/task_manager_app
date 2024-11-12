import 'package:flutter/material.dart';
import '../../../utills/project_manager.dart';
import '../../widgets/custom_title_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProjectManager _projectManager = ProjectManager();
  late List<Map<String, dynamic>> userProjects;
  String activeTab = 'Home';

  @override
  void initState() {
    super.initState();
    userProjects = _projectManager.getAllProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // SidebarDrawer omitted for this version
          Expanded(
            child: Column(
              children: [
                const CustomTitleBar(showIcons: false),
                const Text('Welcome to the Dashboard!'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: userProjects.length,
                      itemBuilder: (context, index) {
                        final project = userProjects[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(project['title'] ?? 'Unnamed Project'),
                            subtitle: Text(project['description'] ??
                                'No description available'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
