import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_screen.dart';
import 'task_screen.dart';
import 'calendar_screen.dart';
import 'settings_screen.dart';
import '../widgets/window_controls.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isExpanded = true;
  int _selectedIndex = 0;

  final List<({IconData icon, String label, Widget screen})> _pages = [
    (
      icon: Icons.dashboard_rounded,
      label: 'Dashboard',
      screen: const TaskScreen(),
    ),
    (
      icon: Icons.folder_rounded,
      label: 'Projects',
      screen: const ProjectScreen(),
    ),
    (
      icon: Icons.calendar_today_rounded,
      label: 'Calendar',
      screen: const CalendarScreen(),
    ),
    (
      icon: Icons.settings_rounded,
      label: 'Settings',
      screen: const SettingsScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: _handleKeyPress,
        child: Column(
          children: [
            const WindowControls(),
            Expanded(
              child: Row(
                children: [
                  _buildSidebar(),
                  Expanded(
                    child: Column(
                      children: [
                        _buildTopBar(),
                        Expanded(
                          child: _pages[_selectedIndex].screen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.isControlPressed &&
          event.logicalKey == LogicalKeyboardKey.keyN) {
        _addNewItem();
      } else if (event.isControlPressed &&
          event.logicalKey == LogicalKeyboardKey.keyS) {
        _saveCurrentItem();
      } else if (event.isControlPressed &&
          event.logicalKey == LogicalKeyboardKey.keyD) {
        _deleteCurrentItem();
      }
    }
  }

  void _addNewItem() {
    // Implement adding new task or project based on current screen
  }

  void _saveCurrentItem() {
    // Implement saving current task or project
  }

  void _deleteCurrentItem() {
    // Implement deleting current task or project
  }

  Widget _buildSidebar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _isExpanded ? 250 : 70,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildSidebarHeader(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _buildNavSection('MAIN', [0, 1]),
                  const SizedBox(height: 16),
                  _buildNavSection('TOOLS', [2, 3]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarHeader() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(
            Icons.task_alt_rounded,
            size: 32,
            color: Theme.of(context).colorScheme.primary,
          ),
          if (_isExpanded) ...[
            const SizedBox(width: 12),
            Text(
              'Task Manager',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const Spacer(),
          IconButton(
            icon: Icon(_isExpanded ? Icons.chevron_left : Icons.chevron_right),
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavSection(String title, List<int> indices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
        ...indices.map((index) => _buildNavItem(index)),
      ],
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = _selectedIndex == index;
    final page = _pages[index];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          page.icon,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
        ),
        title: _isExpanded
            ? Text(
                page.label,
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: _isExpanded ? 16 : 0,
          vertical: 4,
        ),
        horizontalTitleGap: 0,
        selected: isSelected,
        onTap: () => setState(() => _selectedIndex = index),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            _pages[_selectedIndex].label,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              // Implement search functionality
            },
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () {
              // Implement notifications
            },
          ),
          const SizedBox(width: 16),
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
