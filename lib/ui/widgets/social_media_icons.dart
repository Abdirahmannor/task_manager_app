import 'package:flutter/material.dart';

class SocialMediaIcons extends StatelessWidget {
  const SocialMediaIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.facebook),
        const SizedBox(width: 13),
        _buildSocialIcon(Icons.g_mobiledata),
        const SizedBox(width: 16),
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
      padding: const EdgeInsets.all(12),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
