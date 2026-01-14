import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppTextStyles {
  /// AppBar Title Style for Light Theme
  static TextStyle appBarTitle(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontXl,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    );
  }

  /// Headline (Big Bold Text)
  static TextStyle headline(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontXxl,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    );
  }

  /// Title (Section Titles)
  static TextStyle titleBlack(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontLg,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    );
  }

  static TextStyle titleWhite(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontLg,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    );
  }

  static TextStyle titleWhiteXl(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontXl,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    );
  }

  /// Body Text (Normal paragraph or row)
  static TextStyle body(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontMd,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    );
  }

  /// Label Text (Light-weight small captions)
  static TextStyle label(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontSm,
      color: AppColors.grey,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle label2(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontSm,
      color: AppColors.black,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle labelMd(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontMd,
      color: AppColors.grey,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle labelLg(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontLg,
      color: AppColors.grey,
      fontWeight: FontWeight.w500,
    );
  }

  /// Caption / Footnote
  static TextStyle caption(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontXs,
      color: AppColors.grey,
    );
  }

  /// Button text style
  static TextStyle button(BuildContext context) {
    return const TextStyle(
      fontSize: AppSizes.fontMd,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    );
  }

  static TextStyle bodyPrimary(BuildContext context) => const TextStyle(
        fontSize: AppSizes.fontMd,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle bodyBlack(BuildContext context) => const TextStyle(
        fontSize: AppSizes.fontMd,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      );


  static TextStyle bodySecondary(BuildContext context) => const TextStyle(
        fontSize: AppSizes.fontMd,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle labelDisabled(BuildContext context) => const TextStyle(
        fontSize: AppSizes.fontSm,
        color: AppColors.textDisabled,
      );

  /// Light TextTheme (used in ThemeData)
  static TextTheme get lightTextTheme => const TextTheme(
        bodyLarge: TextStyle(fontSize: AppSizes.fontLg, color: AppColors.black),
        bodyMedium:
            TextStyle(fontSize: AppSizes.fontMd, color: AppColors.black),
        bodySmall: TextStyle(fontSize: AppSizes.fontSm, color: AppColors.grey),
        labelLarge:
            TextStyle(fontSize: AppSizes.fontSm, fontWeight: FontWeight.w600),
        titleSmall:
            TextStyle(fontSize: AppSizes.fontLg, fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(
          fontSize: AppSizes.fontXxl,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        headlineMedium: TextStyle(
          fontSize: AppSizes.fontXl,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        headlineSmall: TextStyle(
          fontSize: AppSizes.fontXs,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      );

  /// Dark TextTheme (used in ThemeData.dark())
  static TextTheme get darkTextTheme => const TextTheme(
        bodyLarge:
            TextStyle(fontSize: AppSizes.fontLg, color: AppColors.white70),
        bodyMedium:
            TextStyle(fontSize: AppSizes.fontMd, color: AppColors.white),
        bodySmall: TextStyle(fontSize: AppSizes.fontSm, color: AppColors.white),
        labelLarge: TextStyle(
            fontSize: AppSizes.fontSm,
            fontWeight: FontWeight.w600,
            color: AppColors.white),
        titleSmall: TextStyle(
            fontSize: AppSizes.fontLg,
            fontWeight: FontWeight.w600,
            color: AppColors.white),
        headlineLarge: TextStyle(
            fontSize: AppSizes.fontXxl,
            fontWeight: FontWeight.bold,
            color: AppColors.white),
      );
}
