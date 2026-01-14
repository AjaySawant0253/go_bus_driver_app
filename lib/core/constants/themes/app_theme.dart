import 'package:flutter/material.dart';
import 'package:go_bus_driver_app/core/constants/app_colors.dart';
import 'text_styles.dart';
import 'button_styles.dart';
import 'input_decoration.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData.light();

    return base.copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.secondaryLightBackground,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        secondary: AppColors.cyan,
        background: AppColors.secondaryLightBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      textTheme: AppTextStyles.textTheme,
      elevatedButtonTheme: AppButtonStyles.elevatedButtonTheme,
      inputDecorationTheme: AppInputDecorations.inputTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: AppTextStyles.appBarTitle,
      ),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark();

    return base.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.secondaryDarkBackground,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        secondary: AppColors.cyan,
        background: AppColors.secondaryDarkBackground,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      textTheme: AppTextStyles.textThemeDark,
      elevatedButtonTheme: AppButtonStyles.elevatedButtonTheme,
      inputDecorationTheme: AppInputDecorations.inputThemeDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: AppTextStyles.appBarTitleDark,
      ),
    );
  }
}
