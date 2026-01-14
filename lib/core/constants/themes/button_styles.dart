import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';

class AppButtonStyles {
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    minimumSize: const Size(double.infinity, 48),
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.alternate,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 2,
  );

  static final ElevatedButtonThemeData elevatedButtonTheme =
      ElevatedButtonThemeData(style: elevatedButtonStyle);
}
