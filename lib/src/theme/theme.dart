import 'package:flutter/material.dart';

class AppTheme {
  static const Color _yellowAccent = Color(0xFFFFC700);
  static const Color _darkBlack = Color(0xFF121212);
  static const Color _mediumBlack = Color(0xFF1F1F1F);
  static const Color _lightWhite = Color(0xFFF5F5F5);

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _yellowAccent,
      onPrimary: Colors.black,
      secondary: _yellowAccent,
      onSecondary: Colors.black,
      tertiary: _yellowAccent,
      onTertiary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: _lightWhite,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _yellowAccent,
      foregroundColor: Colors.black,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: _yellowAccent,
      onPrimary: Colors.black,
      secondary: _yellowAccent,
      onSecondary: Colors.black,
      tertiary: _yellowAccent,
      onTertiary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.white,
      background: _darkBlack,
      onBackground: Colors.white,
      surface: _mediumBlack,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: _darkBlack,
    visualDensity: VisualDensity.adaptivePlatformDensity,

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _yellowAccent,
      foregroundColor: Colors.black,
    ),

    cardColor: _mediumBlack,
  );
}
