import 'package:flutter/material.dart';
import '../../widgets/custom_title_bar.dart';

class HelpScreen extends StatefulWidget {
  // Change to StatefulWidget
  const HelpScreen({super.key});

  @override
  HelpScreenState createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen> {
  late List<Map<String, dynamic>> userProjects;
  String activeTab = 'Help'; // Set the active tab to Home initially

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
                      'Help Content Here', // Example content for the screen
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
