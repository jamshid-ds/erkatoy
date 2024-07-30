import 'package:flutter/material.dart';

import 'app_colors.dart';

class MaterialTheme {
  MaterialTheme._();

  static ThemeData get lightTheme => theme(AppColors.lightScheme);
  static ThemeData get darkTheme => theme(AppColors.darkScheme);

  static ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );
}
