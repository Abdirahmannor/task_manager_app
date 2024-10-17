import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget child;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;

  AuthCard({
    required this.child,
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth < 800 ? screenWidth * 0.85 : maxWidth ?? 400.0,
      constraints: BoxConstraints(
        minWidth: minWidth ?? 300,
        maxWidth: maxWidth ?? 400,
        minHeight: minHeight ?? 500,
        maxHeight: maxHeight ?? screenHeight * 0.9,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}
