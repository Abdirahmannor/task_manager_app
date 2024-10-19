import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  // Start with light theme
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify listeners to rebuild UI
  }
}
