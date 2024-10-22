import 'package:flutter/material.dart';
import '../../widgets/custom_title_bar.dart';
import '../../widgets/sidebar_drawer.dart';

class TasksScreen extends StatefulWidget {
  // Change to StatefulWidget
  const TasksScreen({super.key});

  @override
  TasksScreenState createState() => TasksScreenState();
}

class TasksScreenState extends State<TasksScreen> {
  late List<Map<String, dynamic>> userProjects;
  String activeTab = 'Tasks'; // Set the active tab to Home initially

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return const Scaffold(
      body: Row(children: [
        // SidebarDrawer(
        //   onPageSelected: (page) {
        //     // Handle page navigation
        //     setState(() {
        //       activeTab =
        //           page; // Update the active tab based on sidebar selection
        //     });
        //   },
        //   activeTab: activeTab, // Pass the active tab to the SidebarDrawer
        // ),
        Expanded(
          // Ensure the content expands to fill the screen
          child: Column(
            children: [
              CustomTitleBar(showIcons: true),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'Tasks Content Here', // Example content for the screen
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
