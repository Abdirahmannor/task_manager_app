import 'package:flutter/material.dart';

import '../../widgets/custom_title_bar.dart';

class SchoolManagementScreen extends StatefulWidget {
  // Change to StatefulWidget
  const SchoolManagementScreen({super.key});

  @override
  SchoolManagementScreenState createState() => SchoolManagementScreenState();
}

class SchoolManagementScreenState extends State<SchoolManagementScreen> {
  late List<Map<String, dynamic>> userProjects;
  String activeTab =
      'School Management'; // Set the active tab to Home initially

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
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
              CustomTitleBar(showIcons: false),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      'School Management Content Here', // Example content for the screen
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
