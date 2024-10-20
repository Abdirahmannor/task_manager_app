import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_manager.dart';
import '../../theme/app_theme.dart';
import '../screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'sidebar_tab_card.dart';

class SidebarDrawer extends StatefulWidget {
  final Function(String) onPageSelected;

  const SidebarDrawer({super.key, required this.onPageSelected});

  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
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
          ? AppTheme.darkSidebarBackgroundColor
          : AppTheme.lightSidebarBackgroundColor,
      child: Column(
        children: [
          // Profile Section
          Container(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppTheme.darkSidebarProfileBackgroundColor
                  : AppTheme.lightsidebarProfileBackgroundColor,
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
                  backgroundColor: isDarkMode
                      ? AppTheme.darkBackgroundColor
                      : AppTheme.backgroundColor,
                  child: Text(
                    'JD',
                    style: TextStyle(
                      color: isDarkMode
                          ? AppTheme.darkTextColor
                          : AppTheme.textColor,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'John Doe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDarkMode
                        ? AppTheme.darkTextColor
                        : AppTheme.textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Web Developer',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isDarkMode
                        ? AppTheme.darkTextColor
                        : AppTheme.textColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Space after the profile section

          // Arrow Button - Positioning in the right corner
          Container(
            alignment: Alignment.topRight, // Align to the top right
            margin: const EdgeInsets.only(
                top: 10, right: 10), // Margin for positioning
            child: Material(
              shape: const CircleBorder(), // Define shape here
              color: isDarkMode
                  ? AppTheme.darkSidebarIconColor
                  : AppTheme.lightsidebarIconColor
                      .withOpacity(0.8), // Background color
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color:
                      isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
                ),
                onPressed: () {
                  // Action for the arrow button
                  // Implement functionality here, like collapsing the sidebar
                },
                padding: const EdgeInsets.all(12), // Adjust padding as needed
              ),
            ),
          ),

          // Scrollable Navigation Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTab(
                    icon: Icons.dashboard,
                    label: 'Dashboard',
                    isActive: activeTab == 'Dashboard',
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
    bool isHovering = false; // Track hover state

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovering = true; // Set hovering state to true
        });
      },
      onExit: (_) {
        setState(() {
          isHovering = false; // Set hovering state to false
        });
      },
      child: SidebarTabCard(
        title: label,
        icon: icon,
        isActive: isActive || isHovering,
        onTap: () {
          setState(() {
            activeTab = label; // Set the active tab
          });
          widget.onPageSelected(label);
        },
      ),
    );
  }
}
