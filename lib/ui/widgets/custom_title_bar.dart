import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import '../../theme/app_theme.dart';

class CustomTitleBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showIcons;

  const CustomTitleBar({super.key, required this.showIcons});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onPanUpdate: (details) {
        appWindow.startDragging(); // Allows the whole title bar to be draggable
      },
      child: Container(
        color: isDarkMode
            ? AppTheme.darkBackgroundColor // Use dark background color
            : AppTheme.backgroundColor, // Use light background color
        height: 40.0,
        child: Row(
          children: [
            // if (showIcons) // Show Back Icon only when showIcons is true
            //   IconButton(
            //     icon: const Icon(Icons.arrow_back, color: Colors.white),
            //     onPressed: () {
            //       Navigator.pushReplacementNamed(context, '/signIn');
            //     },
            //   ),
            Expanded(child: MoveWindow()), // Allows user to drag the window
            // if (showIcons) // Show Logout Icon only when showIcons is true
            //   IconButton(
            //     icon: const Icon(Icons.logout, color: Colors.white),
            //     onPressed: () {
            //       // Clear the user session
            //       final sessionManager = SessionManager();
            //       sessionManager.clearUserSession();

            //       // Redirect to Sign In page
            //       Navigator.pushReplacementNamed(context, '/signIn');
            //     },
            //   ),
            MinimizeWindowButton(),
            MaximizeWindowButton(),
            CloseWindowButton(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(40.0); // Set the height of the title bar
}
