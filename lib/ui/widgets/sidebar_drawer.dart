import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/user_model.dart';
import '../../theme/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_section.dart';
import 'sidebar_tab_card.dart';
import '../../data/database/database_helper.dart'; // Import your database helper

class SidebarDrawer extends StatefulWidget {
  final Function(String) onPageSelected;

  const SidebarDrawer({super.key, required this.onPageSelected});

  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  String activeTab = 'Dashboard'; // Track the active tab
  bool isSidebarCollapsed = false; // Track if the sidebar is collapsed
  String searchQuery = ''; // Variable to hold the current search query

  String userInitials = ""; // Fetch user's initials dynamically
  String userName = ""; // Fetch user's name dynamically
  String userRole = ""; // Fetch user's role dynamically

  DatabaseHelper _dbHelper =
      DatabaseHelper(); // Create an instance of DatabaseHelper

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the widget initializes
  }

  Future<void> _fetchUserData() async {
    // Fetch the user's email from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email =
        prefs.getString('email') ?? ''; // Replace with the actual email key
    User? user = await _dbHelper.getUserByEmail(email); // Fetch user by email

    if (user != null) {
      setState(() {
        userInitials = user.username.isNotEmpty
            ? user.username[0]
            : 'U'; // Set initials (first character of username)
        userName = user.name; // Set user's name
        userRole = user.role; // Set user's role correctly
      });
    }
  }

  bool _matchesSearch(String label) {
    return label.toLowerCase().contains(searchQuery.toLowerCase());
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDarkMode
          ? AppTheme.darkSidebarBackgroundColor
          : AppTheme.lightSidebarBackgroundColor,
      child: Column(
        children: [
          // Profile Section
          ProfileSection(
            userInitials: userInitials,
            userName: userName,
            userRole: userRole, // Fetch user's role dynamically
          ),

          const SizedBox(height: 20), // Space after the profile section

          // Arrow Button - Positioning in the right corner
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.only(top: 10, right: 10),
            child: MouseRegion(
              child: Material(
                shape: const CircleBorder(),
                color: isDarkMode
                    ? AppTheme.darkSidebarIconColor
                    : AppTheme.lightsidebarIconColor.withOpacity(0.8),
                elevation: 4,
                child: IconButton(
                  icon: AnimatedRotation(
                    turns: isSidebarCollapsed ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.chevron_right,
                      color: isDarkMode
                          ? AppTheme.darkTextColor
                          : AppTheme.textColor,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isSidebarCollapsed =
                          !isSidebarCollapsed; // Toggle sidebar state
                    });
                  },
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ),
          ),

          // Scrollable Navigation Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value; // Update search query
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        filled: true,
                        fillColor: isDarkMode
                            ? AppTheme.darkSidebarIconColor
                            : AppTheme.lightsidebarIconColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: isDarkMode
                              ? AppTheme.darkTextColor
                              : AppTheme.textColor,
                        ),
                      ),
                    ),
                  ),

                  // Filtered tabs based on the search query
                  if (_matchesSearch('Dashboard'))
                    _buildTab(
                        icon: Icons.dashboard,
                        label: 'Dashboard',
                        isActive: activeTab == 'Dashboard'),
                  if (_matchesSearch('Projects'))
                    _buildTab(
                        icon: Icons.folder,
                        label: 'Projects',
                        isActive: activeTab == 'Projects'),
                  if (_matchesSearch('Tasks'))
                    _buildTab(
                        icon: Icons.task,
                        label: 'Tasks',
                        isActive: activeTab == 'Tasks'),
                  if (_matchesSearch('School Management'))
                    _buildTab(
                        icon: Icons.school,
                        label: 'School Management',
                        isActive: activeTab == 'School Management'),
                  if (_matchesSearch('Resources'))
                    _buildTab(
                        icon: Icons.library_books,
                        label: 'Resources',
                        isActive: activeTab == 'Resources'),
                  if (_matchesSearch('Notes'))
                    _buildTab(
                        icon: Icons.note,
                        label: 'Notes',
                        isActive: activeTab == 'Notes'),

                  const SizedBox(height: 10), // Space before the divider
                  const Divider(color: Colors.red),
                  const SizedBox(height: 10), // Space after the divider
                ],
              ),
            ),
          ),

          // Settings/Help/Logout Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                _buildTab(
                    icon: Icons.settings,
                    label: 'Settings',
                    isActive: activeTab == 'Settings'),
                _buildTab(
                    icon: Icons.help,
                    label: 'Help',
                    isActive: activeTab == 'Help'),

                // Dark Mode Toggle Switch
                ListTile(
                  leading: Icon(
                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    color: isDarkMode
                        ? AppTheme.darkTextColor
                        : AppTheme.textColor,
                  ),
                  title: Text(
                    'Dark Mode',
                    style: AppTheme.sidebarTextStyle.copyWith(
                      color: isDarkMode
                          ? AppTheme.darkTextColor
                          : AppTheme.textColor,
                    ),
                  ),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      themeManager.toggleTheme(); // Call the toggleTheme method
                    },
                  ),
                ),
                // Logout Button
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: Text(
                    'Logout',
                    style: AppTheme.sidebarTextStyle.copyWith(
                      color: AppTheme.sidebarTextColor,
                    ),
                  ),
                  onTap: () => _logout(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Inside the _buildTab method
  Widget _buildTab({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return SidebarTabCard(
      title: label,
      icon: icon,
      isActive: isActive,
      onTap: () {
        setState(() {
          activeTab = label; // Set the active tab
        });

        // Navigate to the corresponding screen based on the tab selected
        switch (label) {
          case 'Dashboard':
            Navigator.pushNamed(context, '/projects');
            break;
          case 'Projects':
            Navigator.pushNamed(context, '/projects');
            break;
          case 'Tasks':
            Navigator.pushNamed(context, '/tasks');
            break;
          case 'School Management':
            Navigator.pushNamed(context, '/schoolManagement');
            break;
          case 'Resources':
            Navigator.pushNamed(
                context, '/resources'); // Make sure to define this route
            break;
          case 'Notes':
            Navigator.pushNamed(
                context, '/notes'); // Make sure to define this route
            break;
          case 'Settings':
            // Add navigation logic for Settings if needed
            break;
          case 'Help':
            // Add navigation logic for Help if needed
            break;
          default:
            break;
        }

        widget.onPageSelected(label); // Call the onPageSelected function
      },
    );
  }
}
