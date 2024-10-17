import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class CustomTitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue, // Set custom color here
      height: 40.0,
      child: Row(
        children: [
          Expanded(child: MoveWindow()), // Allows user to drag the window
          MinimizeWindowButton(),
          MaximizeWindowButton(),
          CloseWindowButton(),
        ],
      ),
    );
  }
}
