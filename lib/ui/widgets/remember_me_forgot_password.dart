import 'package:flutter/material.dart';

class RememberMeForgotPassword extends StatelessWidget {
  final bool rememberMe;
  final void Function(bool?) onRememberMeChanged;
  final VoidCallback onForgotPassword;
  final double screenWidth;

  const RememberMeForgotPassword({
    Key? key,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onForgotPassword,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CheckboxListTile(
                value: rememberMe,
                onChanged: onRememberMeChanged,
                title: Text('Remember me'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            if (screenWidth > 800)
              TextButton(
                onPressed: onForgotPassword,
                child: const Text(
                  'Forgot password',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
          ],
        ),
        if (screenWidth <= 800)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onForgotPassword,
              child: const Text(
                'Forgot password',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
      ],
    );
  }
}
