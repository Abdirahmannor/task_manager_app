import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'theme/theme_manager.dart';
import 'ui/screens/sign_in_screen.dart';
import 'ui/screens/sign_up_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/widgets/custom_title_bar.dart';
import 'utills/window_manager_util.dart'; // Import the window manager utility

void main() async {
  await configureWindow(); // Call the function to configure the window

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeManager.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: '/signIn',
      routes: {
        '/signIn': (context) => SignInScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
      },
      builder: (context, child) {
        return WindowTitleBarBox(
          child: Column(
            children: [
              CustomTitleBar(),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 800,
                        minHeight: 600,
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
