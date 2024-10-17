import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_navigation_buttons.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_card.dart';

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

  void signUp() {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        // Perform the sign-up action
        print(
            "Signing up with name: \$name, email: \$email and password: \$password");
        Navigator.pushReplacementNamed(context, '/signIn');
      } else {
        // Show error if passwords do not match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields.'),
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
                          child: AuthCard(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Header
                                AuthHeader(title: "Create an Account"),
                                SizedBox(height: 16),
                                // Name TextField
                                AuthTextField(
                                  controller: nameController,
                                  hint: "Name",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.person),
                                    onPressed: null,
                                  ),
                                ),
                                SizedBox(height: 16),
                                // Email TextField
                                AuthTextField(
                                  controller: emailController,
                                  hint: "Email",
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
                                SizedBox(height: 24),
                                // Sign Up Button
                                CustomButton(
                                  text: "Sign Up",
                                  isSelected: true,
                                  onPressed: signUp,
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
                  onSignInPressed: () {
                    Navigator.pushReplacementNamed(context, '/signIn');
                  },
                  onSignUpPressed: () {},
                  isSignInSelected: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
