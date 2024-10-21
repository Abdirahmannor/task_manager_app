import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme/app_theme.dart';
import 'theme/theme_manager.dart';
import 'ui/screens/project_screens/note_screen.dart';
import 'ui/screens/project_screens/project_screens.dart';
import 'ui/screens/project_screens/resources_screen.dart';
import 'ui/screens/project_screens/school_management_screen.dart';
import 'ui/screens/project_screens/tasks_screen.dart';
import 'ui/screens/sign_in_screen.dart';
import 'ui/screens/sign_up_screen.dart';
import 'ui/screens/home_screen.dart';

import 'utills/window_manager_util.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await Hive.initFlutter();
  await Hive.openBox('userBox');
  await Hive.openBox('sessionBox');
  await Hive.openBox('projectsBox');

  await configureWindow();

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
        '/signIn': (context) => const SignInScreen(),
        '/signUp': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/projects': (context) => const ProjectsScreen(),
        '/tasks': (context) => const TasksScreen(),
        '/schoolManagement': (context) => const SchoolManagementScreen(),
        '/resources': (context) =>
            const ResourcesScreen(), // Add Resources route
        '/notes': (context) => const NoteScreen(), // Add Notes route
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
                        minWidth: 1024,
                        minHeight: 800,
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
