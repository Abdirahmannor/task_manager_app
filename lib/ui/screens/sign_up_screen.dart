import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_text_field.dart'; // Import AuthTextField
import '../widgets/custom_button.dart'; // Import CustomButton
import '../widgets/remember_me_forgot_password.dart'; // Import RememberMeForgotPassword
import '../widgets/social_media_icons.dart'; // Import SocialMediaIcons

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signUp() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);

    // Navigate to Sign In Screen after successful sign up
    Navigator.pushReplacementNamed(context, '/signIn');
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
                    child: SingleChildScrollView(
                      child: AuthCard(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Sign up Text
                            const Text(
                              "Create an Account",
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
                            // Name TextField
                            AuthTextField(
                              controller: _nameController,
                              hint: "Name",
                            ),
                            SizedBox(height: 16),
                            // Email TextField
                            AuthTextField(
                              controller: _emailController,
                              hint: "Email",
                            ),
                            SizedBox(height: 16),
                            // Password TextField
                            AuthTextField(
                              controller: _passwordController,
                              hint: "Password",
                              obscureText: true,
                            ),
                            SizedBox(height: 16),
                            // Confirm Password TextField
                            AuthTextField(
                              controller: _confirmPasswordController,
                              hint: "Confirm Password",
                              obscureText: true,
                            ),
                            SizedBox(height: 24),
                            // Sign Up Button
                            CustomButton(
                              text: "Sign Up",
                              isSelected: true,
                              onPressed: _signUp,
                            ),
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
                CustomButton(
                  text: "Sign In",
                  isSelected: false,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signIn');
                  },
                ),
                const SizedBox(width: 50),
                CustomButton(
                  text: "Sign Up",
                  isSelected: true,
                  onPressed: _signUp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
