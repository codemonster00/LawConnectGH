import 'package:flutter/material.dart';

/// LawConnect GH brand colors - Deep blue/navy + gold accents for legal/trust vibes
class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF1B365D); // Deep navy blue
  static const Color primaryLight = Color(0xFF2E5984);
  static const Color primaryDark = Color(0xFF0F2440);
  
  // Gold Accents  
  static const Color accent = Color(0xFFD4AF37); // Legal gold
  static const Color accentLight = Color(0xFFE8C547);
  static const Color accentDark = Color(0xFFC19B26);
  
  // Semantic Colors
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
  
  // Neutral Colors
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textInverse = Color(0xFFFFFFFF);
  
  // Background Colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFE5E7EB);
  
  // Ghana-specific colors
  static const Color ghanaRed = Color(0xFFCE1126);
  static const Color ghanaGold = Color(0xFFFCD116);
  static const Color ghanaGreen = Color(0xFF006B3F);
  static const Color ghanaBlack = Color(0xFF000000);
  
  // Legal status colors
  static const Color verified = Color(0xFF22C55E);
  static const Color pending = Color(0xFFF59E0B);
  static const Color rejected = Color(0xFFEF4444);
  static const Color available = Color(0xFF22C55E);
  static const Color busy = Color(0xFFEF4444);
  static const Color offline = Color(0xFF6B7280);
  
  // Payment colors
  static const Color mtnYellow = Color(0xFFFFCB05);
  static const Color vodafoneRed = Color(0xFFE60000);
  static const Color airtelRed = Color(0xFFED1C24);
}

/// Material 3 Color Scheme for LawConnect GH
ColorScheme get lawConnectColorScheme => ColorScheme.fromSeed(
  seedColor: AppColors.primary,
  brightness: Brightness.light,
  primary: AppColors.primary,
  secondary: AppColors.accent,
  surface: AppColors.surface,
  background: AppColors.background,
  error: AppColors.error,
);

ColorScheme get lawConnectDarkColorScheme => ColorScheme.fromSeed(
  seedColor: AppColors.primary,
  brightness: Brightness.dark,
  primary: AppColors.primaryLight,
  secondary: AppColors.accentLight,
);