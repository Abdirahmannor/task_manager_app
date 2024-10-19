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
  bool isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // Back Arrow Positioned at the Top-right corner
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                color: isDarkMode
                    ? Colors.white
                    : Colors.black87, // Adapt to dark mode
              ),
              onPressed: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                });
              },
            ),
          ),

          // Scrollable content to avoid overflow
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center everything vertically
                children: [
                  // Profile Section Centered
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor:
                              isDarkMode ? Colors.white : Colors.blueAccent,
                          child: Text(
                            'JD',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: isDarkMode ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Web Developer',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Center the navigation items just like the profile
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center items
                    children: [
                      _buildListTile(Icons.dashboard, 'Dashboard', 'Dashboard',
                          context, isDarkMode),
                      _buildListTile(Icons.person, 'Profile', 'Profile',
                          context, isDarkMode),
                      _buildListTile(Icons.star, 'Favorites', 'Favorites',
                          context, isDarkMode),
                      _buildListTile(Icons.calendar_today, 'Calendar',
                          'Calendar', context, isDarkMode),
                      _buildListTile(
                          Icons.note, 'Notes', 'Notes', context, isDarkMode),
                    ],
                  ),

                  // Bottom section remains scrollable as well
                  Column(
                    children: [
                      const Divider(),
                      _buildListTile(Icons.settings, 'Settings', 'Settings',
                          context, isDarkMode),
                      _buildListTile(Icons.help_outline, 'Help', 'Help',
                          context, isDarkMode),
                      const Divider(),
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
                      _buildListTile(Icons.logout, 'Logout', 'Logout', context,
                          isDarkMode),
                    ],
                  ),
                ],
              ),
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
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
      onTap: () => widget.onPageSelected(page),
    );
  }
}
