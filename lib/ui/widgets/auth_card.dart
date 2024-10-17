import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  AuthCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = constraints.maxWidth * 0.4;
        double containerHeight = constraints.maxHeight * 0.6;

        // Ensure the card doesn't shrink too much
        if (containerWidth < 300) {
          containerWidth = 300;
        }
        if (containerHeight < 400) {
          containerHeight = 400;
        }

        return Container(
          width: containerWidth,
          height: containerHeight,
          constraints: BoxConstraints(
            minWidth: 300,
            minHeight: 400,
            maxWidth: 500,
            maxHeight: 600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                18), // Ensure rounded corners are applied to scrollable content
            child: SingleChildScrollView(
              child: child,
            ),
          ),
        );
      },
    );
  }
}
