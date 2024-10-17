import 'package:flutter/material.dart';

class AuthNavigationButtons extends StatefulWidget {
  final VoidCallback onSignInPressed;
  final VoidCallback onSignUpPressed;
  final bool isSignInSelected;
  final EdgeInsetsGeometry margin;

  AuthNavigationButtons({
    required this.onSignInPressed,
    required this.onSignUpPressed,
    required this.isSignInSelected,
    this.margin = const EdgeInsets.only(left: 50, bottom: 30),
  });

  @override
  _AuthNavigationButtonsState createState() => _AuthNavigationButtonsState();
}

class _AuthNavigationButtonsState extends State<AuthNavigationButtons> {
  bool isSignInHovered = false;
  bool isSignUpHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Row(
        children: [
          MouseRegion(
            onEnter: (_) {
              setState(() {
                isSignInHovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                isSignInHovered = false;
              });
            },
            child: GestureDetector(
              onTap: widget.onSignInPressed,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.isSignInSelected
                      ? Colors.blue
                      : (isSignInHovered
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                  boxShadow: isSignInHovered
                      ? [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 6,
                          ),
                        ]
                      : [],
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color:
                        widget.isSignInSelected ? Colors.white : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 50),
          MouseRegion(
            onEnter: (_) {
              setState(() {
                isSignUpHovered = true;
              });
            },
            onExit: (_) {
              setState(() {
                isSignUpHovered = false;
              });
            },
            child: GestureDetector(
              onTap: widget.onSignUpPressed,
              child: Container(
                decoration: BoxDecoration(
                  color: !widget.isSignInSelected
                      ? Colors.blue
                      : (isSignUpHovered
                          ? Colors.blue.withOpacity(0.2)
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                  boxShadow: isSignUpHovered
                      ? [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 6,
                          ),
                        ]
                      : [],
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color:
                        !widget.isSignInSelected ? Colors.white : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
