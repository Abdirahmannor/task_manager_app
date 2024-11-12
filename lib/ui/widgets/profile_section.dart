import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileSection extends StatelessWidget {
  final String userInitials; // Initials of the user
  final String userName; // Full name of the user
  final String userRole; // User role

  const ProfileSection({
    super.key,
    required this.userInitials,
    required this.userName,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: isDarkMode
                ? AppTheme.darkBackgroundColor
                : AppTheme.backgroundColor,
            child: Text(
              userInitials, // Display initials here
              style: TextStyle(
                color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Hi', // Display greeting with user's name
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            userName, // Display user role
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
}
