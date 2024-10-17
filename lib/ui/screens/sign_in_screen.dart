import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_navigation_buttons.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_card.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isPasswordVisible = false;
  bool rememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // Perform the sign-in action
      print("Signing in with email: $email and password: $password");
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
                        return SingleChildScrollView(
                          child: AuthCard(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Header
                                AuthHeader(title: "Sign in to Account"),
                                SizedBox(height: 16),
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
                                SizedBox(height: 16),
                                // Remember Me and Forgot Password
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
                                    Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        // Forgot password action
                                      },
                                      child: Text(
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
}
