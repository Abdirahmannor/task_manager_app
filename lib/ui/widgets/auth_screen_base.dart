import 'package:flutter/material.dart';
import '../widgets/auth_card.dart';
import '../widgets/social_media_icons.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class AuthScreenBase extends StatelessWidget {
  final Widget formContent;
  final String headerTitle;
  final Widget? bottomNavigation;

  AuthScreenBase({
    required this.formContent,
    required this.headerTitle,
    this.bottomNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Dark Overlay
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/img1.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Title bar
              WindowTitleBarBox(
                child: Row(
                  children: [
                    Expanded(child: MoveWindow()),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double cardWidth = constraints.maxWidth * 0.6;
                        double minCardWidth = 300;
                        double maxCardWidth = 600;
                        cardWidth = cardWidth.clamp(minCardWidth, maxCardWidth);

                        return SingleChildScrollView(
                          child: AuthCard(
                            child: Container(
                              width: cardWidth,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Header
                                  Text(
                                    headerTitle,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  // Social Media Icons
                                  SocialMediaIcons(),
                                  SizedBox(height: 24),
                                  // Form Content
                                  formContent,
                                  SizedBox(height: 16),
                                  // Privacy Policy and Terms
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "privacy policy",
                                        style: TextStyle(
                                            color: Colors.brown, fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(
                                        "terms and conditions",
                                        style: TextStyle(
                                            color: Colors.brown, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              if (bottomNavigation != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, left: 150),
                  child: bottomNavigation!,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
