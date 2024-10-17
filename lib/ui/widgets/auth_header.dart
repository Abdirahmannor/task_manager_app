import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;

  AuthHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
