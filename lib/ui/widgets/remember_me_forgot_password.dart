import 'package:flutter/material.dart';

class RememberMeForgotPassword extends StatelessWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onForgotPassword;

  const RememberMeForgotPassword({
    Key? key,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onForgotPassword,
  }) : super(key: key);

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
            Text("Remember me"),
          ],
        ),
        TextButton(
          onPressed: onForgotPassword,
          child: Text(
            "Forgot password",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
