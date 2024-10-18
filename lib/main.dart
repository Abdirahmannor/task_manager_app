import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme/app_theme.dart';
import 'theme/theme_manager.dart';
import 'ui/screens/sign_in_screen.dart';
import 'ui/screens/sign_up_screen.dart';
import 'ui/screens/home_screen.dart';
import 'utills/window_manager_util.dart'; // Import the window manager utility

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open boxes
  await Hive.initFlutter();
  await Hive.openBox('userBox'); // Box to store user data
  await Hive.openBox('sessionBox'); // Box to store session information
  await Hive.openBox('projectsBox'); // Box to store project information

  await configureWindow(); // Call the function to configure the window before running the app

  final sessionBox = Hive.box('sessionBox');
  final bool isLoggedIn = sessionBox.get('isLoggedIn', defaultValue: false);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeManager.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: isLoggedIn ? '/home' : '/signIn',
      routes: {
        '/signIn': (context) => SignInScreen(),
        '/signUp': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
      builder: (context, child) {
        return WindowTitleBarBox(
          child: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 1024, // Ensure minimum width
                        minHeight: 800, // Ensure minimum height
                      ),
                      child: child!,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
