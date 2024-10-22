import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/ui/screens/project_screens/note_screen.dart';
import 'package:task_manager_app/ui/screens/project_screens/resources_screen.dart';
import 'package:task_manager_app/ui/screens/project_screens/school_management_screen.dart';
import 'package:task_manager_app/ui/screens/project_screens/settings_screen.dart';
import 'package:task_manager_app/ui/screens/project_screens/tasks_screen.dart';
import '../../widgets/sidebar_drawer.dart';
import 'project_screens.dart';
import 'home_screen.dart';
import 'help_screen.dart'; // Import your Help screen

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String activeTab = 'Home'; // Default active tab

  void onPageSelected(String page) {
    setState(() {
      activeTab = page; // Update the active tab
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget contentScreen;

    // Select the content based on active tab
    switch (activeTab) {
      case 'Home':
        contentScreen = const HomeScreen();
        break;
      case 'Projects':
        contentScreen = const ProjectsScreen();
        break;
      case 'Tasks':
        contentScreen = const TasksScreen();
        break;
      case 'School management':
        contentScreen = const SchoolManagementScreen();
        break;
      case 'Resources':
        contentScreen = const ResourcesScreen();
        break;
      case 'Notes':
        contentScreen = const NoteScreen();
        break;
      case 'Settings':
        contentScreen = const SettingsScreen();
        break;
      case 'Help': // Add case for Help screen
        contentScreen = const HelpScreen();
        break;
      // Add cases for other screens
      default:
        contentScreen = const HomeScreen();
    }

    return Scaffold(
      body: Row(
        children: [
          SidebarDrawer(
            onPageSelected: onPageSelected,
            activeTab: activeTab, // Pass active tab to SidebarDrawer
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  60, // Adjust height as needed
              child: contentScreen, // Display the selected content screen
            ),
          ),
        ],
      ),
    );
  }
}
