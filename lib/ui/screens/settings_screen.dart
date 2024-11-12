import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _showNotifications = true;
  String _defaultView = 'List';

  @override
  void initState() {
    super.initState();
    _isDarkMode = context.read<ThemeProvider>().isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            'Appearance',
            [
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Toggle dark/light theme'),
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
              ListTile(
                title: const Text('Default View'),
                subtitle: Text(_defaultView),
                trailing: const Icon(Icons.chevron_right),
                onTap: _showViewOptions,
              ),
            ],
          ),
          const Divider(),
          _buildSection(
            'Notifications',
            [
              SwitchListTile(
                title: const Text('Enable Notifications'),
                subtitle: const Text('Get reminders for tasks and projects'),
                value: _showNotifications,
                onChanged: (value) {
                  setState(() {
                    _showNotifications = value;
                  });
                },
              ),
            ],
          ),
          const Divider(),
          _buildSection(
            'About',
            [
              ListTile(
                title: const Text('Version'),
                subtitle: const Text('1.0.0'),
              ),
              ListTile(
                title: const Text('Developer'),
                subtitle: const Text('Your Name'),
                onTap: () {
                  // Add developer info or website link
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  void _showViewOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('List View'),
                leading: Radio<String>(
                  value: 'List',
                  groupValue: _defaultView,
                  onChanged: (value) {
                    setState(() {
                      _defaultView = value!;
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Grid View'),
                leading: Radio<String>(
                  value: 'Grid',
                  groupValue: _defaultView,
                  onChanged: (value) {
                    setState(() {
                      _defaultView = value!;
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
