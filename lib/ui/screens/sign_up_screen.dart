import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import '../widgets/custom_button.dart'; // Import your custom button
import 'package:shared_preferences/shared_preferences.dart';

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
                    // WindowButtons(),
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
                            constraints: BoxConstraints(
                              minWidth: 300,
                              maxWidth: 400,
                              minHeight: 500,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.9,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
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
                                // Name TextField
                                _buildTextField(
                                  controller: _nameController,
                                  hint: "Name",
                                ),
                                SizedBox(height: 16),
                                // Email TextField
                                _buildTextField(
                                  controller: _emailController,
                                  hint: "Email",
                                ),
                                SizedBox(height: 16),
                                // Password TextField
                                _buildTextField(
                                  controller: _passwordController,
                                  hint: "Password",
                                  obscureText: true,
                                ),
                                SizedBox(height: 16),
                                // Confirm Password TextField
                                _buildTextField(
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
  }) {
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
}
