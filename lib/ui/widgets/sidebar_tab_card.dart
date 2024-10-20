import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';

class SidebarTabCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const SidebarTabCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: isActive ? 8 : 2, // Elevation based on active state
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        color:
            isActive ? AppTheme.sidebarSelectedColor : AppTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12), // Padding inside the card
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppTheme.darkIsHover
                      : isDarkMode
                          ? AppTheme.darkSidebarIconColor
                          : AppTheme.lightSidebarBackgroundColor,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: isActive ? Colors.black54 : Colors.transparent,
                      blurRadius: 4.0,
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: isDarkMode
                      ? AppTheme.darkiconcolor
                      : AppTheme.lighticoncolor,
                ),
              ),
              const SizedBox(width: 10), // Space between icon and text
              Text(
                title,
                style: AppTheme.sidebarTextStyle.copyWith(
                  color:
                      isDarkMode ? AppTheme.darkTextColor : AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
