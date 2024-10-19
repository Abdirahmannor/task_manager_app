import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SidebarDrawer extends StatefulWidget {
  final Function(String) onPageSelected;

  const SidebarDrawer({Key? key, required this.onPageSelected})
      : super(key: key);

  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  bool isCollapsed = false;
  String activeTab = 'Dashboard'; // Track the active tab

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
          ? AppTheme.sidebarBackgroundColor
          : AppTheme.backgroundColor,
      child: Column(
        children: [
          // Profile Section
          Container(
            decoration: BoxDecoration(
              color: AppTheme.sidebarBackgroundColor.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: AppTheme.sidebarIconColor,
                  child: const Text(
                    'JD',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'John Doe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Web Developer',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Space after the profile section

          // Scrollable Navigation Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTab(
                    icon: Icons.dashboard,
                    label: 'Dashboard',
                    isActive: activeTab == 'Dashboard', // Check if active
                  ),
                  _buildTab(
                    icon: Icons.person,
                    label: 'Profile',
                    isActive: activeTab == 'Profile',
                  ),
                  _buildTab(
                    icon: Icons.star,
                    label: 'Favorites',
                    isActive: activeTab == 'Favorites',
                  ),
                  _buildTab(
                    icon: Icons.calendar_today,
                    label: 'Calendar',
                    isActive: activeTab == 'Calendar',
                  ),
                  _buildTab(
                    icon: Icons.note,
                    label: 'Notes',
                    isActive: activeTab == 'Notes',
                  ),
                  const Divider(color: Colors.white), // Optional divider
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
                  isActive: activeTab == 'Settings',
                ),
                _buildTab(
                  icon: Icons.help,
                  label: 'Help',
                  isActive: activeTab == 'Help',
                ),
                // Dark Mode Toggle Switch
                ListTile(
                  leading: Icon(
                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    color: AppTheme.sidebarIconColor,
                  ),
                  title: Text(
                    'Dark Mode',
                    style: AppTheme.sidebarTextStyle.copyWith(
                      color: AppTheme.sidebarTextColor,
                    ),
                  ),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      themeManager.toggleTheme();
                    },
                  ),
                ),
                // Logout Button
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
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

  Widget _buildTab({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return MouseRegion(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.sidebarSelectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color:
                  isActive ? AppTheme.sidebarIconColor : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppTheme.sidebarIconColor,
            ),
          ),
          title: Text(
            label,
            style: AppTheme.sidebarTextStyle.copyWith(
              color: isActive ? Colors.white : AppTheme.sidebarTextColor,
            ),
          ),
          onTap: () {
            setState(() {
              activeTab = label; // Update active tab on click
            });
            widget.onPageSelected(label);
          },
        ),
      ),
    );
  }
}
