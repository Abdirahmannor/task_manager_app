import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_navigation_buttons.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_card.dart';
import '../widgets/custom_title_bar.dart';
import '../../data/models/user_model.dart'; // Import User model

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController =
      TextEditingController(); // New username controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _userBox = Hive.box('userBox');

  void signUp() async {
    setState(() {
      isLoading = true; // Set loading to true when sign-up starts
    });

    final name = nameController.text.trim();
    final username = usernameController.text.trim(); // Get username input
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isNotEmpty &&
        username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        if (_userBox.containsKey(email)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email already exists!'),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // Save new user data
          final newUser = User(
            username: email, // Assuming username is the email
            password: password,
            email: email,
            name: name, // Make sure to include the name
            role: 'User', // Set a default role or get it dynamically
          );

          _userBox.put(email, newUser.toMap()); // Save new user
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

    setState(() {
      isLoading = false; // Set loading to false when sign-up is complete
    });
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
                  const CustomTitleBar(showIcons: false),
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
                              // Username TextField
                              AuthTextField(
                                controller:
                                    usernameController, // Username input
                                hint: "Username", // Hint for username
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
                              isLoading
                                  ? const CircularProgressIndicator()
                                  : CustomButton(
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
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : AuthNavigationButtons(
                              onSignInPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/signIn');
                              },
                              onSignUpPressed: signUp,
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
