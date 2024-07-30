import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static ColorScheme get lightScheme => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF297811),
        onPrimary: Color(0xFFF5FFF3),
        secondary: Color(0xFF88AF7D),
        onSecondary: Color(0xFF13170F),
        error: Color(0xFFB3261E),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFFFBFFFA),
        onSurface: Color(0xFF171916),
      );

  static ColorScheme get darkScheme => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF297811),
        onPrimary: Color(0xFFF5FFF3),
        secondary: Color(0xFF88AF7D),
        onSecondary: Color(0xFFF5FFF3),
        error: Color(0xFFB3261E),
        onError: Color(0xFFFFFFFF),
        surface: Color(0xFF1C201B),
        onSurface: Color(0xFFD0D5CE),
      );
}
