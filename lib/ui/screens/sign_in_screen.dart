import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../widgets/auth_card.dart';
import '../widgets/social_media_icons.dart';
import '../widgets/remember_me_forgot_password.dart';
import '../widgets/sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool rememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // Perform the sign-in action
      print("Signing in with email: \$email and password: \$password");
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password.'),
          backgroundColor: AppTheme.accentColor,
        ),
      );
    }
  }

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
              WindowTitleBarBox(
                child: Row(
                  children: [
                    Expanded(child: MoveWindow()),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 60.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: AuthCard(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Sign in Text
                                Text(
                                  "Sign in to Account",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.copyWith(color: AppTheme.primaryColor),
                                ),
                                SizedBox(height: 16),
                                // Social Media Icons
                                SocialMediaIcons(),
                                SizedBox(height: 24),
                                // Email TextField
                                _buildTextField(
                                  controller: emailController,
                                  hint: "Gmail",
                                ),
                                SizedBox(height: 16),
                                // Password TextField
                                _buildTextField(
                                  controller: passwordController,
                                  hint: "Password",
                                  obscureText: true,
                                ),
                                const SizedBox(height: 16),
                                // Remember Me and Forgot Password
                                RememberMeForgotPassword(
                                  rememberMe: rememberMe,
                                  onRememberMeChanged: (value) {
                                    setState(() {
                                      rememberMe = value!;
                                    });
                                  },
                                ),

                                SizedBox(height: 24),
                                // Sign In Button
                                SignInButton(onPressed: signIn),
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
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Bottom Navigation Buttons
          Positioned(
            bottom: 30,
            left: 150,
            child: Row(
              children: [
                _buildBottomButton(context, "Sign In", true, signIn),
                SizedBox(width: 50),
                _buildNavigationButton(context, "Sign Up", false, '/signUp'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String hint,
      bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context, String text, bool isSelected,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, String text, bool isSelected, String route) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(157, 33, 149, 243)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// class WindowButtons extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         // MinimizeWindowButton(),
//         // MaximizeWindowButton(),
//         // CloseWindowButton(),
//       ],
//     );
//   }
// }
