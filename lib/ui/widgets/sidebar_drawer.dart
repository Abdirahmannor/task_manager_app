import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_manager.dart';

class SidebarDrawer extends StatelessWidget {
  final Function(String) onPageSelected;

  const SidebarDrawer({Key? key, required this.onPageSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      // Background color based on dark or light mode
      backgroundColor: Theme.of(context)
          .colorScheme
          .surface, // Use the surface color for better dark/light adaptation
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.black54
                  : Colors.blue, // Adapted for dark mode
            ),
            child: UserAccountsDrawerHeader(
              accountName: Text(
                'John Doe',
                style: TextStyle(
                    color: isDarkMode
                        ? Colors.white
                        : Colors.black87), // Dark mode text color
              ),
              accountEmail: Text(
                'Web Developer',
                style: TextStyle(
                    color: isDarkMode
                        ? Colors.white70
                        : Colors.black54), // Dark mode text color
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: isDarkMode ? Colors.white : Colors.blueAccent,
                child: Text(
                  'JD',
                  style: TextStyle(
                      fontSize: 24.0,
                      color: isDarkMode
                          ? Colors.black
                          : Colors.white), // Dark mode text color
                ),
              ),
              decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black54 : Colors.blue),
            ),
          ),

          // Main navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildListTile(Icons.dashboard, 'Dashboard', 'Dashboard',
                    context, isDarkMode),
                _buildListTile(
                    Icons.person, 'Profile', 'Profile', context, isDarkMode),
                _buildListTile(
                    Icons.star, 'Favorites', 'Favorites', context, isDarkMode),
                _buildListTile(Icons.calendar_today, 'Calendar', 'Calendar',
                    context, isDarkMode),
                _buildListTile(
                    Icons.note, 'Notes', 'Notes', context, isDarkMode),
              ],
            ),
          ),

          const Divider(), // Divider between main navigation and settings/help

          // Settings and Help
          _buildListTile(
              Icons.settings, 'Settings', 'Settings', context, isDarkMode),
          _buildListTile(
              Icons.help_outline, 'Help', 'Help', context, isDarkMode),

          const Divider(), // Divider before dark mode toggle and logout

          // Dark Mode Toggle
          SwitchListTile(
            title: const Text("Dark Mode"),
            secondary: Icon(
              themeManager.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            value: themeManager.themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              themeManager.toggleTheme();
            },
          ),

          // Logout button at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildListTile(
                Icons.logout, 'Logout', 'Logout', context, isDarkMode),
          ),
        ],
      ),
    );
  }

  // Helper function to build ListTile widgets with proper dark mode adaptations
  Widget _buildListTile(IconData icon, String title, String page,
      BuildContext context, bool isDarkMode) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Icon(icon,
          color: isDarkMode
              ? Colors.white
              : Colors.black87), // Dark mode icon color
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDarkMode
              ? Colors.white
              : Colors.black87, // Dark mode text color
        ),
      ),
      onTap: () => onPageSelected(page),
    );
  }
}
