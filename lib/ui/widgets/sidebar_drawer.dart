import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_manager.dart';

class SidebarDrawer extends StatefulWidget {
  final Function(String) onPageSelected;

  const SidebarDrawer({Key? key, required this.onPageSelected})
      : super(key: key);

  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  bool isCollapsed =
      false; // For handling the back arrow collapse functionality

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor:
          Theme.of(context).colorScheme.surface, // Unified background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surface, // Same background for the header
            ),
            child: Stack(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    'John Doe',
                    style: TextStyle(
                        color: isDarkMode
                            ? Colors.white
                            : Colors.black87), // Adapt to dark mode
                  ),
                  accountEmail: Text(
                    'Web Developer',
                    style: TextStyle(
                        color: isDarkMode
                            ? Colors.white70
                            : Colors.black54), // Adapt to dark mode
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        isDarkMode ? Colors.white : Colors.blueAccent,
                    child: Text(
                      'JD',
                      style: TextStyle(
                          fontSize: 24.0,
                          color: isDarkMode
                              ? Colors.black
                              : Colors.white), // Adapt to dark mode
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surface, // Ensure background matches the sidebar
                  ),
                ),

                // Back Arrow Icon at the top-right
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      isCollapsed
                          ? Icons.arrow_forward_ios
                          : Icons.arrow_back_ios, // Collapsible behavior
                      color: isDarkMode
                          ? Colors.white
                          : Colors.black87, // Adapt icon color to dark mode
                    ),
                    onPressed: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          // Divider with improved visibility
          Divider(
            color: isDarkMode
                ? Colors.white54
                : Colors.black38, // More prominent divider in dark mode
            thickness: 1, // Slightly thicker divider for better visibility
          ),

          // Navigation items...
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

                const Divider(), // Regular divider between navigation and settings/help

                _buildListTile(Icons.settings, 'Settings', 'Settings', context,
                    isDarkMode),
                _buildListTile(
                    Icons.help_outline, 'Help', 'Help', context, isDarkMode),

                const Divider(), // Regular divider before dark mode toggle and logout

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
                _buildListTile(
                    Icons.logout, 'Logout', 'Logout', context, isDarkMode),
              ],
            ),
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
              : Colors.black87), // Icon color adapted to dark mode
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: isDarkMode
              ? Colors.white
              : Colors.black87, // Text color adapted to dark mode
        ),
      ),
      onTap: () =>
          widget.onPageSelected(page), // Trigger page selection callback
    );
  }
}
