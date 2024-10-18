import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/theme_manager.dart';
import '../screens/school_activities_screen.dart';
import '../screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({super.key});

  @override
  SidebarDrawerState createState() => SidebarDrawerState();
}

class SidebarDrawerState extends State<SidebarDrawer> {
  bool isCollapsed = true;

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

    return Drawer(
      child: Column(
        children: [
          // Header with a collapsible button
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    isCollapsed
                        ? Icons.arrow_forward_ios
                        : Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isCollapsed = !isCollapsed;
                    });
                  },
                ),
                if (!isCollapsed)
                  const Expanded(
                    child: Text(
                      'FocusHub',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Search bar
          if (!isCollapsed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          if (!isCollapsed) const SizedBox(height: 10),
          // Navigation options
          Expanded(
            child: ListView(
              children: [
                _buildListTile(
                  context,
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
                _buildListTile(
                  context,
                  icon: Icons.school,
                  label: 'School Activities',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SchoolActivitiesScreen()),
                    );
                  },
                ),
                _buildListTile(
                  context,
                  icon: Icons.event,
                  label: 'Calendar',
                  onTap: () {
                    Navigator.pushNamed(context, '/calendar');
                  },
                ),
                // Add more list tiles for shortcuts, notes, etc.
              ],
            ),
          ),
          // Dark/light mode toggle
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: Icon(
                themeManager.themeMode == ThemeMode.light
                    ? Icons.brightness_4
                    : Icons.brightness_7,
              ),
              title: const Text('Toggle Theme'),
              onTap: () {
                themeManager.toggleTheme();
              },
            ),
          ),
          // Logout button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title:
                  const Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                _logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon,
      required String label,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: isCollapsed
          ? null
          : Text(label, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
      hoverColor: Colors.blueGrey[800],
    );
  }
}
