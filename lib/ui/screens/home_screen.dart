import 'package:flutter/material.dart';
import '../../utills/session_manager.dart'; // Import SessionManager

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SessionManager sessionManager = SessionManager();

    void logout() {
      sessionManager.clearUserSession(); // Clear the user session
      Navigator.pushReplacementNamed(
          context, '/signIn'); // Navigate to Sign-In screen
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout, // Call the logout function
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
