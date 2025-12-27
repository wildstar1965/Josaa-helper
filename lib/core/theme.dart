import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFFEE8C2B);
  static const Color backgroundLight = Color(0xFFF8F7F6);
  static const Color textPrimary = Color(0xFF1B140D);
  static const Color textSecondary = Color(0xFF9A734C);

  static ThemeData light = ThemeData(
    fontFamily: "Plus Jakarta Sans",
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundLight,
    useMaterial3: true,

    colorScheme: ColorScheme.light(
      primary: primary,
      surface: Colors.white,
      onSurface: textPrimary,
    ),
  );
}
