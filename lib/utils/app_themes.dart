import 'package:flutter/material.dart';

class AppThemes {
  //light theme
  static final lightTheme = ThemeData(
    primaryColor: Colors.orange[800],
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,

    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFff9800),
      primary: const Color(0xFFff9800),
      brightness: Brightness.light,
      surface: Colors.white,
    ),
    cardColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.orange[800],
      unselectedItemColor: Colors.grey,
    ),
  );
  //dark theme
  static final darkTheme = ThemeData(
    primaryColor: Colors.orange[800],
    scaffoldBackgroundColor: const Color(0xFF121212),
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFff9800),
      primary: const Color(0xFFff9800),
      brightness: Brightness.dark,
      surface: const Color(0xFF1E1E1E),
    ),
    cardColor: const Color(0xFF1E1E1E),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF1E1E1E),
      selectedItemColor: Colors.orange[800],
      unselectedItemColor: Colors.grey,
    ),
  );
}
