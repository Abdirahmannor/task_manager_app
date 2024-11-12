import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/project_screen.dart';
import 'package:task_manager_app/ui/screens/project_screens/resources_screen.dart';
import 'package:task_manager_app/ui/screens/project_screens/school_management_screen.dart';
import 'package:task_manager_app/ui/screens/project_screens/settings_screen.dart';
import 'package:task_manager_app/ui/screens/project_screens/tasks_screen.dart';
import '../../widgets/sidebar_drawer.dart';
import 'note_screen.dart';
// import 'project_screens.dart';
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
        contentScreen = const ProjectScreen();
        break;
      case 'Tasks':
        contentScreen = const TasksScreen();
        break;
      case 'School Management':
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
            child: Column(
              children: [
                // const CustomTitleBar(
                //     showIcons: true), // Place the title bar here
                Expanded(
                  child: Container(
                    child: contentScreen, // Display the selected content screen
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
