import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileSection extends StatelessWidget {
  final String userInitials;
  final String userName;
  final String userRole;

  const ProfileSection({
    Key? key,
    required this.userInitials,
    required this.userName,
    required this.userRole,
  }) : super(key: key);

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
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: isDarkMode
                ? AppTheme.darkBackgroundColor
                : AppTheme.backgroundColor,
            child: Text(
              userInitials,
              style: TextStyle(
                color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            userName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            userRole,
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
