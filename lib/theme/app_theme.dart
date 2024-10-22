import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define centralized color scheme
  static const Color primaryColor =
      Color.fromARGB(255, 5, 80, 48); // Main Color
  static const Color accentColor =
      Color.fromARGB(255, 27, 17, 85); // Accent Color

  // Light Mode Colors
  static const Color backgroundColor =
      Color.fromARGB(255, 82, 80, 81); // Light Background
  static const Color lightSidebarBackgroundColor =
      Color.fromARGB(255, 49, 47, 44); // Light Sidebar Background
  static const Color sidebarBackgroundColor =
      Color.fromARGB(255, 19, 168, 81); // Light Mode Sidebar Background
  static const Color lightsidebarProfileBackgroundColor =
      Color.fromARGB(255, 31, 28, 29); // Light Mode Profile section background
  static const Color sidebarSelectedColor =
      Color.fromARGB(255, 45, 69, 141); // Light Mode Active tab color
  static const Color lightsidebarIconColor =
      Color.fromARGB(255, 129, 128, 128); // Light Mode Icon color
  static const Color sidebarInactiveIconColor =
      Color(0xFFB0BEC5); // Light Mode Inactive icon color
  static const Color sidebarTextColor =
      Color.fromARGB(255, 243, 240, 240); // Light Mode Sidebar text color
  static const Color lighticoncolor = textColor;
  static const Color buttonColor = Color(0xFF1A73E8); // Button Color
  static const Color textColor =
      Color.fromARGB(255, 240, 239, 239); // Main Text Color
  static const Color cardBackgroundColor =
      Color.fromARGB(255, 221, 19, 19); // Card Background Color
  static const Color LightIsHover =
      Color.fromARGB(255, 22, 107, 33); // Light Hover

  // Dark Mode Colors
  static const Color darkBackgroundColor =
      Color(0XFFf041955); // Dark Background
  static const Color darkTextColor =
      Color.fromARGB(255, 238, 236, 237); // Light Text Color
  static const Color darksidebarArrowColor =
      Color.fromARGB(255, 90, 122, 15); // Light Mode Sidebar Arrow icon
  static const Color darkCardColor =
      Color.fromARGB(255, 212, 90, 8); // Dark Card Background
  static const Color darkSidebarBackgroundColor =
      Color.fromARGB(255, 8, 25, 122); // Dark Sidebar Background
  static const Color darkSidebarProfileBackgroundColor =
      Color.fromARGB(255, 6, 160, 121); // Dark Mode Profile section background
  static const Color darkSidebarSelectedColor =
      Color(0XFFf041955); // Dark Mode Active tab color (green)
  static const Color darkSidebarIconColor =
      Color.fromARGB(255, 69, 38, 126); // Dark Mode Icon color
  static const Color darkSidebarInactiveIconColor =
      Color.fromARGB(255, 2, 78, 116); // Dark Mode Inactive icon color
  static const Color darkSidebarTextColor =
      Color.fromARGB(255, 226, 222, 222); // Dark Mode Sidebar text color
  static const Color darkIsHover = Color.fromARGB(255, 25, 9, 63); // Dark Hover
  static const Color darkiconcolor = darkTextColor;

  // New Additions for Consistency
  static const Color dialogBackgroundColorLight =
      Color(0xFFF2F2F2); // Light Mode Dialog Background
  static const Color dialogBackgroundColorDark =
      Color(0xFF2D2D2D); // Dark Mode Dialog Background

  // Font Styles for Sidebar
  static final TextStyle sidebarTextStyle = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: sidebarTextColor,
  );

  static final TextStyle sidebarActiveTextStyle = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Define font styles for other sections
  static final TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
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
    dialogBackgroundColor: dialogBackgroundColorLight,
    dividerColor: Colors.grey.withOpacity(0.2),
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
    dialogBackgroundColor: dialogBackgroundColorDark,
    dividerColor: Colors.grey.withOpacity(0.5),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.dark,
      primary: primaryColor,
      secondary: accentColor,
      surface: darkBackgroundColor,
    ),
  );
}
