import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define centralized color scheme
  static const Color primaryColor =
      Color.fromARGB(255, 5, 80, 48); // Main Color
  static const Color accentColor =
      Color.fromARGB(255, 27, 17, 85); // Accent Color

  // Light Mode Colors
  static const Color backgroundColor = Color(0Xffccc0c8); // Light Background
  static const Color sidebarBackgroundColor =
      Color.fromARGB(255, 18, 175, 57); // Light Mode Sidebar Background
  static const Color sidebarProfileBackgroundColor =
      Color(0xFF504e4f); // Light Mode Profile section background
  static const Color sidebarSelectedColor =
      Color(0xFF4CAF50); // Light Mode Active tab color (green)
  static const Color sidebarIconColor = Colors.white; // Light Mode Icon color
  static const Color sidebarInactiveIconColor =
      Color(0xFFB0BEC5); // Light Mode Inactive icon color
  static const Color sidebarTextColor =
      Colors.black; // Light Mode Sidebar text color

  static const Color buttonColor = Color(0xFF1A73E8); // Button Color
  static const Color textColor =
      Color.fromARGB(255, 119, 12, 12); // Main Text Color
  static const Color cardBackgroundColor =
      Color.fromARGB(255, 29, 28, 28); // Card Background Color

  // Dark Mode Colors
  static const Color darkBackgroundColor = Color(0xFF1d1b1c); // Dark Background
  static const Color darkTextColor = Color(0xFFDDCFD9); // Light Text Color
  static const Color darkCardColor =
      Color.fromARGB(255, 4, 22, 71); // Dark Card Background
  static const Color darkSidebarBackgroundColor =
      Color.fromARGB(255, 209, 13, 13); // Dark Mode Sidebar Background
  static const Color darkSidebarProfileBackgroundColor =
      Color(0xFF3A3A3A); // Dark Mode Profile section background
  static const Color darkSidebarSelectedColor =
      Color(0xFF4CAF50); // Dark Mode Active tab color (green)
  static const Color darkSidebarIconColor =
      Color.fromARGB(255, 11, 143, 77); // Dark Mode Icon color
  static const Color darkSidebarInactiveIconColor =
      Color(0xFFB0BEC5); // Dark Mode Inactive icon color
  static const Color darkSidebarTextColor =
      Colors.white; // Dark Mode Sidebar text color

  static final TextStyle sidebarTextStyle = GoogleFonts.openSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: sidebarTextColor,
  );

  // Define font styles
  static final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    bodyLarge: GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: textColor,
    ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: textColor,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  // Light Theme Data
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardBackgroundColor,
    textTheme: textTheme,
    buttonTheme: ButtonThemeData(
      buttonColor: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
        textStyle: textTheme.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: accentColor,
      surface: backgroundColor,
    ),
  );

  // Dark Theme Data
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    cardColor: darkCardColor,
    textTheme: textTheme.apply(
      bodyColor: darkTextColor,
      displayColor: darkTextColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
        textStyle: textTheme.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.dark,
      primary: primaryColor,
      secondary: accentColor,
      surface: darkBackgroundColor,
    ),
  );
}
