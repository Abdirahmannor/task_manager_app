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
  bool isSidebarCollapsed = false; // Track if the sidebar is collapsed

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
          _buildProfileSection(isDarkMode),

          // Arrow Button - Positioning in the right corner
          _buildCollapseButton(isDarkMode),

          // Scrollable Navigation Section
          _buildNavigationSection(),

          // Settings/Help/Logout Section
          _buildSettingsSection(isDarkMode, themeManager),
        ],
      ),
    );
  }

  Widget _buildProfileSection(bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.darkSidebarProfileBackgroundColor
            : AppTheme.lightsidebarProfileBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
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
                color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'John Doe',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Web Developer',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapseButton(bool isDarkMode) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 10, right: 10),
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
              color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
            ),
          ),
          onPressed: () {
            setState(() {
              isSidebarCollapsed = !isSidebarCollapsed;
            });
          },
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget _buildNavigationSection() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTab(
                icon: Icons.dashboard,
                label: 'Dashboard',
                isActive: activeTab == 'Dashboard'),
            _buildTab(
                icon: Icons.person,
                label: 'Profile',
                isActive: activeTab == 'Profile'),
            _buildTab(
                icon: Icons.star,
                label: 'Favorites',
                isActive: activeTab == 'Favorites'),
            _buildTab(
                icon: Icons.calendar_today,
                label: 'Calendar',
                isActive: activeTab == 'Calendar'),
            _buildTab(
                icon: Icons.note,
                label: 'Notes',
                isActive: activeTab == 'Notes'),
            const SizedBox(height: 10),
            const Divider(color: Colors.red),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection(bool isDarkMode, ThemeManager themeManager) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          _buildTab(
              icon: Icons.settings,
              label: 'Settings',
              isActive: activeTab == 'Settings'),
          _buildTab(
              icon: Icons.help, label: 'Help', isActive: activeTab == 'Help'),
          ListTile(
            leading: Icon(
              isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
            ),
            title: Text(
              'Dark Mode',
              style: AppTheme.sidebarTextStyle.copyWith(
                color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
              ),
            ),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                themeManager.toggleTheme(); // Call the toggleTheme method
              },
            ),
          ),
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
    );
  }

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
        widget.onPageSelected(label);
      },
    );
  }
}
