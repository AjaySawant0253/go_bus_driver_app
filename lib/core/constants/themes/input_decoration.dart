import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';

class AppInputDecorations {
  static const borderRadius = BorderRadius.all(Radius.circular(12));
  static const padding = EdgeInsets.symmetric(horizontal: 16, vertical: 14);

  static final inputTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: padding,
    border: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: AppColors.primary.withOpacity(0.2)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: AppColors.primary, width: 1.5),
    ),
  );

  static final inputThemeDark = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[850],
    contentPadding: padding,
    border: const OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: Colors.white24),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: Colors.white24),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(color: Colors.white70, width: 1.5),
    ),
  );
}
