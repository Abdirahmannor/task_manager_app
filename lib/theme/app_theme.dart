import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define centralized color scheme
  static const Color primaryColor = Color(0xFF1A73E8); // Main Blue Color
  static const Color accentColor = Color(0xFFFFA000); // Accent Color (Orange)
  static const Color backgroundColor = Color(0xFFF1F3F4); // Light Background
  static const Color buttonColor = Color(0xFF1A73E8); // Button Color
  static const Color textColor = Color(0xFF202124); // Main Text Color
  static const Color cardBackgroundColor =
      Colors.white; // Card Background Color

  // Sidebar Colors
  static const Color sidebarBackgroundColor = Color(0xFF2E2E48);
  static const Color sidebarProfileBackgroundColor =
      Color(0xFF1C1C1C); // Profile section background
  static const Color sidebarSelectedColor = primaryColor;
  static const Color sidebarIconColor = Colors.white;
  static const Color sidebarInactiveIconColor =
      Colors.grey; // Inactive icon color
  static const Color sidebarTextColor = Colors.white;

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
    scaffoldBackgroundColor: Colors.black,
    cardColor: const Color(0xFF1E1E1E),
    textTheme: textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
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
      surface: Colors.black,
    ),
  );
}
