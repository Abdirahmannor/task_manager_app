import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_navigation_buttons.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_card.dart';
import '../widgets/custom_title_bar.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _userBox = Hive.box('userBox');

  void signUp() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (!email.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid email address.'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (password == confirmPassword) {
        // Check if the email already exists
        if (_userBox.containsKey(email)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email already exists!'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // Save new user data
          _userBox.put(email, {'name': name, 'password': password});
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, '/signIn');
        }
      } else {
        // Show error if passwords do not match
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          return Stack(
            children: [
              // Background Image with Dark Overlay
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('lib/assets/img1.jpg'),
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
                  const CustomTitleBar(
                      showIcons:
                          false), // Hide Back and Logout icons on Sign In screen
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
                        padding: const EdgeInsets.only(right: 60.0),
                        child: AuthCard(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Header
                              const AuthHeader(title: "Sign in to Account"),
                              const SizedBox(height: 16),
                              // Name TextField
                              AuthTextField(
                                controller: nameController,
                                hint: "Name",
                                suffixIcon: const IconButton(
                                  icon: Icon(Icons.person),
                                  onPressed: null,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Email TextField
                              AuthTextField(
                                controller: emailController,
                                hint: "Email",
                                suffixIcon: const IconButton(
                                  icon: Icon(Icons.email),
                                  onPressed: null,
                                ),
                              ),
                              const SizedBox(height: 16),
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
                              // Confirm Password TextField
                              AuthTextField(
                                controller: confirmPasswordController,
                                hint: "Confirm Password",
                                obscureText: !isConfirmPasswordVisible,
                                suffixIcon: IconButton(
                                  icon: Icon(isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      isConfirmPasswordVisible =
                                          !isConfirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Sign Up Button
                              CustomButton(
                                text: "Sign Up",
                                isSelected: true,
                                onPressed: signUp,
                              ),
                              const SizedBox(height: 16),
                              if (screenWidth < 800)
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/signIn');
                                  },
                                  child: const Text(
                                    "Or Sign in now?",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              const SizedBox(height: 16),
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
                  // Bottom Navigation Buttons
                  if (screenWidth > 800)
                    Positioned(
                      bottom: 30,
                      left: 150,
                      child: AuthNavigationButtons(
                        onSignUpPressed: signUp,
                        onSignInPressed: () {
                          Navigator.pushReplacementNamed(context, '/signIn');
                        },
                        isSignInSelected: false,
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
