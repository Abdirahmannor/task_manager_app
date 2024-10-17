import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_navigation_buttons.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool rememberMe = false;
  bool isPasswordVisible = false;
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
          backgroundColor: Colors.red,
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
                        double containerWidth = constraints.maxWidth < 800
                            ? constraints.maxWidth * 0.85
                            : 400.0;

                        return SingleChildScrollView(
                          child: Container(
                            width: containerWidth,
                            constraints: const BoxConstraints(
                                minWidth: 300,
                                maxWidth: 400,
                                minHeight: 500,
                                maxHeight: double.infinity),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Header
                                AuthHeader(title: "Sign in to Account"),
                                SizedBox(height: 16),
                                // Social Media Icons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildSocialIcon(Icons.facebook),
                                    SizedBox(width: 13),
                                    _buildSocialIcon(Icons.g_mobiledata),
                                    SizedBox(width: 16),
                                    _buildSocialIcon(Icons.call),
                                  ],
                                ),
                                SizedBox(height: 24),
                                // Email TextField
                                AuthTextField(
                                  controller: emailController,
                                  hint: "Gmail",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.email),
                                    onPressed: null,
                                  ),
                                ),
                                SizedBox(height: 16),
                                // Password TextField
                                AuthTextField(
                                  controller: passwordController,
                                  hint: "Password",
                                  obscureText: !isPasswordVisible,
                                  suffixIcon: IconButton(
                                    icon: Icon(isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        isPasswordVisible = !isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Remember Me and Forgot Password
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: rememberMe,
                                          onChanged: (value) {
                                            setState(() {
                                              rememberMe = value!;
                                            });
                                          },
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
                                ),
                                SizedBox(height: 24),
                                // Sign In Button
                                CustomButton(
                                  text: "Sign In",
                                  isSelected: true,
                                  onPressed: signIn,
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
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Bottom Navigation Buttons
              Positioned(
                bottom: 30,
                left: 150,
                child: AuthNavigationButtons(
                  onSignInPressed: () {},
                  onSignUpPressed: () {
                    Navigator.pushReplacementNamed(context, '/signUp');
                  },
                  isSignInSelected: true,
                ),
              ),
            ],
          ),
        ],
      ),
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
