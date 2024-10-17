import 'package:flutter/material.dart';

class SocialMediaIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.facebook),
        SizedBox(width: 13),
        _buildSocialIcon(Icons.g_mobiledata),
        SizedBox(width: 16),
        _buildSocialIcon(Icons.call),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      padding: EdgeInsets.all(12),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
