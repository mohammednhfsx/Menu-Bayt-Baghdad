import 'package:flutter/material.dart';
class AppColors {
  // ── Brand (shared) ───────────────────────────────────────
  static const Color primaryOrange = Color(0xFFE8A020);
  static const Color Orange        = Color(0xFFF5B942);
  static const Color darkOrange    = Color(0xFFC47D10);
  // ── Dark Mode ─────────────────────────────────────────────
  static const Color background  = Color(0xFF120806);
  static const Color bottomNav   = Color(0xFF2A1D19);
  static const Color cardColor   = Color(0xFF241714);
  static const Color border      = Color(0xFF3A2A24);
  static const Color searchFill  = Color(0xFF251C19);
  // ── Light Mode ────────────────────────────────────────────
  static const Color lightBackground  = Color(0xFFFDF8F2);
  static const Color lightCard        = Color(0xFFFFFFFF);
  static const Color lightCardAlt     = Color(0xFFF5EDE0);
  static const Color lightBorder      = Color(0xFFE8DDD0);
  static const Color lightSearchFill  = Color(0xFFFFFFFF);
  static const Color lightBottomNav   = Color(0xFFFFF8EE);
  static const Color lightText        = Color(0xFF1A1208);
  static const Color lightSubText     = Color(0xFF7A6A5A);
  // ── Shared Text ───────────────────────────────────────────
  static const Color white    = Color(0xFFFFFFFF);
  static const Color greyText = Color(0xFF9A9A9A);
  // ── Status ───────────────────────────────────────────────
  static const Color red   = Color(0xFFE84020);
  static const Color green = Color(0xFF2A7A2A);
  static const Color blue  = Colors.blue;
  // ── Gradient helpers ─────────────────────────────────────
  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE65100), Color(0xFFFF9800)],
  );
}
// ── Theme-aware helpers ──────────────────────────────────────
extension AppThemeExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get appBackground => isDark
      ? AppColors.background
      : AppColors.lightBackground;
  Color get appCard => isDark
      ? AppColors.cardColor
      : AppColors.lightCard;
  Color get appCardAlt => isDark
      ? AppColors.bottomNav
      : AppColors.lightCardAlt;
  Color get appBorder => isDark
      ? AppColors.border
      : AppColors.lightBorder;
  Color get appText => isDark
      ? AppColors.white
      : AppColors.lightText;
  Color get appSubText => isDark
      ? AppColors.greyText
      : AppColors.lightSubText;
  Color get appSearchFill => isDark
      ? AppColors.searchFill
      : AppColors.lightSearchFill;
  Color get appBottomNav => isDark
      ? AppColors.bottomNav
      : AppColors.lightBottomNav;
}
//AppTheme___________________________________________________
class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: AppColors.cardColor,
    dividerColor: AppColors.border,
    primaryColor: AppColors.primaryOrange,
    hintColor: AppColors.greyText,
    shadowColor: Colors.black26,
    canvasColor: AppColors.bottomNav,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryOrange,
      surface: AppColors.cardColor,
      onSurface: AppColors.white,
      onBackground: AppColors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.greyText),
      titleMedium: TextStyle(color: AppColors.white),
      titleSmall: TextStyle(color: AppColors.greyText),
    ),
    iconTheme: const IconThemeData(color: AppColors.greyText),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.searchFill,
      hintStyle: const TextStyle(color: AppColors.greyText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
  );
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightCard,
    dividerColor: AppColors.lightBorder,
    primaryColor: AppColors.primaryOrange,
    hintColor: AppColors.lightSubText,
    shadowColor: const Color(0x1A000000),
    canvasColor: AppColors.lightCardAlt,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryOrange,
      surface: AppColors.lightCard,
      onSurface: AppColors.lightText,
      onBackground: AppColors.lightText,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightText),
      bodyMedium: TextStyle(color: AppColors.lightSubText),
      titleMedium: TextStyle(color: AppColors.lightText),
      titleSmall: TextStyle(color: AppColors.lightSubText),
    ),
    iconTheme: const IconThemeData(color: AppColors.lightSubText),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.lightText),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSearchFill,
      hintStyle: const TextStyle(color: AppColors.lightSubText),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
    ),
  );
}