import 'package:flutter/material.dart';
import '../widgets/custom_title_bar.dart'; // Import your custom title bar

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomTitleBar(), // Replace AppBar with CustomTitleBar
          Expanded(
            child: Center(
              child: Text(
                'Welcome to the Home Screen!',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
