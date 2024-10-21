import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SidebarTabCard extends StatefulWidget {
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
  _SidebarTabCardState createState() => _SidebarTabCardState();
}

class _SidebarTabCardState extends State<SidebarTabCard> {
  bool isHovering = false; // Track hover state
  bool isPressed = false; // Track press state

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        setState(() {
          isPressed = true; // Set pressed state to true
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false; // Set pressed state to false
        });
      },
      onTapCancel: () {
        setState(() {
          isPressed = false; // Reset pressed state on cancel
        });
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovering = true; // Set hovering state to true
          });
        },
        onExit: (_) {
          setState(() {
            isHovering = false; // Set hovering state to false
          });
        },
        child: Card(
          elevation: widget.isActive || isHovering ? 8 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          color: widget.isActive
              ? AppTheme.sidebarSelectedColor
              : isHovering || isPressed
                  ? (isDarkMode
                      ? AppTheme.darkIsHover
                      : AppTheme.lightSidebarBackgroundColor)
                  : AppTheme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(12), // Padding inside the card
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isPressed
                        ? AppTheme.darkIsHover // Change color when pressed
                        : isHovering
                            ? (isDarkMode
                                ? AppTheme.darkSidebarIconColor
                                : AppTheme.lightSidebarBackgroundColor)
                            : widget.isActive
                                ? AppTheme.darkIsHover
                                : isDarkMode
                                    ? AppTheme.darkSidebarIconColor
                                    : AppTheme.lightsidebarIconColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: isHovering || isPressed
                            ? Colors.black54
                            : Colors.transparent,
                        blurRadius: 4.0,
                        offset: const Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: isDarkMode
                        ? AppTheme.darkiconcolor
                        : AppTheme.lighticoncolor,
                  ),
                ),
                const SizedBox(width: 10), // Space between icon and text
                Text(
                  widget.title,
                  style: AppTheme.sidebarTextStyle.copyWith(
                    color: isDarkMode
                        ? AppTheme.darkTextColor
                        : AppTheme.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
