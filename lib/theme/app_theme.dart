// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

// Definição das cores
const Color primaryColor = Color.fromARGB(255, 111, 113, 240);
const Color secondaryColor = Color.fromARGB(255, 4, 197, 152);
const Color backgroundColor = Color(0xFF121212);
const Color surfaceColor = Color(0xFF1E1E1E);
const Color errorColor = Color(0xFFCF6679);
const Color lightGray = Color.fromARGB(255, 144, 144, 144);
const Color onPrimaryColor = Color(0xFFFFFFFF);
const Color onBackgroundColor = Color(0xFFE0E0E0);

class AppTheme {
  static final ThemeData themeData = ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: onPrimaryColor,
        onSecondary: secondaryColor,
        onSurface: onBackgroundColor,
        onBackground: onBackgroundColor,
        onError: Colors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: onPrimaryColor),
        bodyMedium: TextStyle(color: onBackgroundColor),
        bodySmall: TextStyle(color: lightGray),
      ),
      appBarTheme: AppBarTheme(
        color: primaryColor,
      ));
}
