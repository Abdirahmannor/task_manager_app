import 'package:flutter/material.dart';
import '../../../utills/project_manager.dart';
import '../../widgets/custom_title_bar.dart';
import '../../widgets/sidebar_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProjectManager _projectManager = ProjectManager();
  late List<Map<String, dynamic>> userProjects;
  String activeTab = 'Home'; // Set the active tab to Home initially

  @override
  void initState() {
    super.initState();
    userProjects = _projectManager.getAllProjects();
  }

  // Function to handle page selection and update active tab
  void onPageSelected(String page) {
    // Handle any additional logic here if needed
    setState(() {
      // Update state or any other necessary actions based on selected page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarDrawer(
            onPageSelected: (page) {
              // Handle page navigation
              setState(() {
                activeTab =
                    page; // Update the active tab based on sidebar selection
              });
            },
            activeTab: activeTab, // Pass the active tab to the SidebarDrawer
          ), // Pass onPageSelected function
          Expanded(
            child: Column(
              children: [
                const CustomTitleBar(showIcons: true),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: userProjects.length,
                      itemBuilder: (context, index) {
                        final project = userProjects[index];
                        return ListTile(
                          title: Text(project['title'] ?? 'Unnamed Project'),
                          subtitle: Text(project['description'] ??
                              'No description available'),
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
