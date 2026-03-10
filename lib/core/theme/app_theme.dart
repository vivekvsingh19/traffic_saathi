import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Primary Colors
  static const Color primaryColor = Color(0xFF1E3A8A); // Deep blue
  static const Color onPrimaryColor = Colors.white; // White text on primary
  static const Color backgroundColor = Color(
    0xFFF8F9FA,
  ); // Off-white background
  static const Color surfaceColor = Colors.white;
  static const Color cardColor = Colors.white;
  static const Color darkAccent = Color(0xFF1F2937); // Dark gray text
  static const Color subtitleColor = Color(
    0xFF6B7280,
  ); // Gray for secondary texts

  // Semantic Colors
  static const Color successColor = Color(0xFF10B981); // Green
  static const Color warningColor = Color(0xFFEF4444); // Red
  static const Color infoColor = Color(0xFF3B82F6); // Blue
  static const Color cautionColor = Color(0xFFF59E0B); // Amber

  // Accent Colors for Modern Design
  static const Color accentPurple = Color(0xFFD9D5FF); // Light purple
  static const Color accentBlue = Color(0xFFDFEAFE); // Light blue
  static const Color accentGreen = Color(0xFFF0FDF4); // Light green
  static const Color accentOrange = Color(0xFFFEF3C7); // Light orange
  static const Color accentRed = Color(0xFFFEE2E2); // Light red
  static const Color accentTeal = Color(0xFFF0FDFA); // Light teal

  // Brand Accent Colors
  static const Color violationRed = Color(
    0xFFDC2626,
  ); // Darker red for violations
  static const Color successGreen = Color(
    0xFF059669,
  ); // Strong green for success
  static const Color infoBlue = Color(0xFF1E40AF); // Darker blue for info

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        surface: backgroundColor,
        onSurface: darkAccent,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: textTheme.copyWith(
        displayLarge: textTheme.displayLarge?.copyWith(color: darkAccent),
        displayMedium: textTheme.displayMedium?.copyWith(color: darkAccent),
        displaySmall: textTheme.displaySmall?.copyWith(color: darkAccent),
        headlineLarge: textTheme.headlineLarge?.copyWith(color: darkAccent),
        headlineMedium: textTheme.headlineMedium?.copyWith(color: darkAccent),
        titleLarge: textTheme.titleLarge?.copyWith(color: darkAccent),
        bodyLarge: textTheme.bodyLarge?.copyWith(color: darkAccent),
        bodyMedium: textTheme.bodyMedium?.copyWith(color: darkAccent),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: darkAccent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: darkAccent,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // consistent 20 radius
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: onPrimaryColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500, // Medium weight
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkAccent,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(color: Colors.grey.shade300),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500, // Medium weight
          ),
        ),
      ),
    );
  }
}
