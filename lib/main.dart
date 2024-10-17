import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:window_manager/window_manager.dart';
import 'theme/app_theme.dart';
import 'theme/theme_manager.dart';
import 'ui/screens/sign_in_screen.dart';
import 'ui/screens/sign_up_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/widgets/custom_title_bar.dart';
// Import the Custom Title Bar

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // Configure the window manager to use a frameless window
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setMinimumSize(const Size(1024, 768));
    await windowManager.show();
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden,
        windowButtonVisibility: false); // Hide default title bar and buttons
  });

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: MyApp(),
    ),
  );

  doWhenWindowReady(() {
    final win = appWindow;
    win.minSize = Size(800, 700);
    win.size = Size(1024, 768);
    win.alignment = Alignment.center;
    win.show();
  });
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
              CustomTitleBar(), // Use custom title bar with your preferred color
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
