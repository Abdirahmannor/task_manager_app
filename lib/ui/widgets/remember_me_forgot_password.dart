import 'package:flutter/material.dart';

class RememberMeForgotPassword extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;

  RememberMeForgotPassword({
    required this.rememberMe,
    required this.onRememberMeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: onRememberMeChanged,
            ),
            Text("Remember me"),
          ],
        ),
        TextButton(
          onPressed: () {
            // Forgot Password Logic
          },
          child: const Text(
            "Forgot password",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
