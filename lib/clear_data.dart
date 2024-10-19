import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Open the required boxes
  await Hive.openBox('userBox');
  await Hive.openBox('sessionBox');
  await Hive.openBox('projectsBox');
  await Hive.openBox('tasksBox');

  // Clear all boxes
  await Hive.box('userBox').clear();
  await Hive.box('sessionBox').clear();
  await Hive.box('projectsBox').clear();
  await Hive.box('tasksBox').clear();

  print("All data has been cleared.");
}


// flutter run lib/clear_data.dart
