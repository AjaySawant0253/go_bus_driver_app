import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle appBarTitleDark = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextTheme textTheme = const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
    bodySmall: TextStyle(fontSize: 12, color: Colors.grey),
    labelLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  static TextTheme textThemeDark = const TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
    bodySmall: TextStyle(fontSize: 12, color: Colors.white54),
    labelLarge: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
    titleSmall: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
  );
}
