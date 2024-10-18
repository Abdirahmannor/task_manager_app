import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var projectsBox = await Hive.openBox('projectsBox');

  // Clear all project data
  await projectsBox.clear();

  print("All project data has been cleared.");
}
