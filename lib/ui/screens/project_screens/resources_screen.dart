import 'package:flutter/material.dart';
import '../../widgets/custom_title_bar.dart';

class ResourcesScreen extends StatefulWidget {
  // Change to StatefulWidget
  const ResourcesScreen({super.key});

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  late List<Map<String, dynamic>> userProjects;
  String activeTab = 'Resources'; // Set the active tab to Home initially

  @override
  Widget build(BuildContext context) {
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
                      'Resources Content Here', // Example content for the screen
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
