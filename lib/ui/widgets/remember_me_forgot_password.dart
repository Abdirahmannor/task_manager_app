import 'package:flutter/material.dart';

class RememberMeForgotPassword extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onForgotPassword;

  const RememberMeForgotPassword({
    super.key,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onForgotPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: onRememberMeChanged,
            ),
            const Text("Remember me"),
          ],
        ),
        TextButton(
          onPressed: onForgotPassword,
          child: const Text(
            "Forgot password",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
