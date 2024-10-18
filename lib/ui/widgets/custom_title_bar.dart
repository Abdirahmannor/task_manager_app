import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import '../../utills/session_manager.dart';

class CustomTitleBar extends StatelessWidget {
  final bool showIcons;

  const CustomTitleBar({super.key, required this.showIcons});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        appWindow.startDragging(); // Allows the whole title bar to be draggable
      },
      child: Container(
        color: Colors.blue, // Set custom color here
        height: 40.0,
        child: Row(
          children: [
            if (showIcons) // Show Back Icon only when showIcons is true
              IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signIn');
                },
              ),
            Expanded(child: MoveWindow()), // Allows user to drag the window
            if (showIcons) // Show Logout Icon only when showIcons is true
              IconButton(
                icon: Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  // Clear the user session
                  final sessionManager = SessionManager();
                  sessionManager.clearUserSession();

                  // Redirect to Sign In page
                  Navigator.pushReplacementNamed(context, '/signIn');
                },
              ),
            MinimizeWindowButton(),
            MaximizeWindowButton(),
            CloseWindowButton(),
          ],
        ),
      ),
    );
  }
}
