import 'package:flutter/material.dart';

class RememberMeForgotPassword extends StatelessWidget {
  final bool rememberMe;
  final void Function(bool?) onRememberMeChanged;
  final VoidCallback onForgotPassword;
  final double screenWidth;

  RememberMeForgotPassword({
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onForgotPassword,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    if (screenWidth < 800) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: onRememberMeChanged,
              ),
              Text('Remember me'),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: onForgotPassword,
              child:
                  Text('Forgot password', style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: rememberMe,
                onChanged: onRememberMeChanged,
              ),
              Text('Remember me'),
            ],
          ),
          TextButton(
            onPressed: onForgotPassword,
            child:
                Text('Forgot password', style: TextStyle(color: Colors.blue)),
          ),
        ],
      );
    }
  }
}
