import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../utills/session_manager.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_navigation_buttons.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/auth_card.dart';
import '../widgets/custom_title_bar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isPasswordVisible = false;
  bool rememberMe = false;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _userBox = Hive.box('userBox');
  final _sessionBox = Hive.box('sessionBox'); // Corrected: Declare session box
  final SessionManager _sessionManager = SessionManager();

  void signIn() async {
    setState(() {
      isLoading = true; // Set loading to true when sign-in starts
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      if (_userBox.containsKey(email)) {
        // Retrieve stored user data
        final storedUser = _userBox.get(email);
        final storedPassword = storedUser['password'];

        if (storedPassword == password) {
          // Save user email to session for project management
          _sessionManager.saveUserSession(email);

          if (rememberMe) {
            await _sessionBox.put('isLoggedIn', true);
          } else {
            await _sessionBox.put('isLoggedIn', false);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign In Successful!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect password!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No account found with this email!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      isLoading = false; // Set loading to false when sign-in is complete
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Header
                              const AuthHeader(title: "Sign in to Account"),
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
                              // Remember Me and Forgot Password
                              if (screenWidth < 1000)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          value: rememberMe,
                                          onChanged: (value) {
                                            setState(() {
                                              rememberMe = value!;
                                            });
                                          },
                                        ),
                                        const Text("Remember me"),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Forgot password",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                )
                              else
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
                                        const Text("Remember me"),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Forgot password",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 24),
                              // Original code for Sign In Button in the SignInScreen
                              // Updated Sign In Button section
                              isLoading
                                  ? const CircularProgressIndicator() // Show loading indicator when isLoading is true
                                  : CustomButton(
                                      text: "Sign In",
                                      isSelected: true,
                                      onPressed: signIn,
                                    ),

                              const SizedBox(height: 16),
                              if (screenWidth < 800)
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/signUp');
                                  },
                                  child: const Text(
                                    "Or Sign up now?",
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
                          ? const CircularProgressIndicator() // Show loading indicator when isLoading is true
                          : AuthNavigationButtons(
                              onSignInPressed: signIn,
                              onSignUpPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/signUp');
                              },
                              isSignInSelected: true,
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
