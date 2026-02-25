import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  // Typography Scale with Google Fonts
  
  // Hero Titles (28-32px, Bold, -0.5 letter spacing)
  static TextStyle heroTitle({Color? color}) => GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    color: color ?? AppColors.textPrimary,
    height: 1.2,
  );
  
  static TextStyle heroTitleMedium({Color? color}) => GoogleFonts.plusJakartaSans(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    color: color ?? AppColors.textPrimary,
    height: 1.2,
  );
  
  // Page Titles (24px, Bold)
  static TextStyle pageTitle({Color? color}) => GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: color ?? AppColors.textPrimary,
    height: 1.3,
  );
  
  // Section Headers (20px, SemiBold)
  static TextStyle sectionHeader({Color? color}) => GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
    height: 1.4,
  );
  
  // Card Titles (18px, SemiBold)
  static TextStyle cardTitle({Color? color}) => GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
    height: 1.4,
  );
  
  // Subtitles (16px, Medium)
  static TextStyle subtitle({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textSecondary,
    height: 1.5,
  );
  
  // Body Text (15-16px, Regular)
  static TextStyle bodyLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: color ?? AppColors.textPrimary,
    height: 1.5,
  );
  
  static TextStyle body({Color? color}) => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: color ?? AppColors.textPrimary,
    height: 1.5,
  );
  
  static TextStyle bodyMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimary,
    height: 1.5,
  );
  
  // Small Text (14px)
  static TextStyle small({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: color ?? AppColors.textSecondary,
    height: 1.4,
  );
  
  static TextStyle smallMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimary,
    height: 1.4,
  );
  
  // Captions (13px, secondary color)
  static TextStyle caption({Color? color}) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: color ?? AppColors.textSecondary,
    height: 1.4,
  );
  
  static TextStyle captionMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textSecondary,
    height: 1.4,
  );
  
  // Micro Text (12px)
  static TextStyle micro({Color? color}) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: color ?? AppColors.textTertiary,
    height: 1.3,
  );
  
  // Button Text
  static TextStyle buttonLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textInverse,
    height: 1.2,
  );
  
  static TextStyle button({Color? color}) => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textInverse,
    height: 1.2,
  );
  
  static TextStyle buttonSmall({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textInverse,
    height: 1.2,
  );
  
  // Special Styles
  static TextStyle badge({Color? color}) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textInverse,
    height: 1.2,
    letterSpacing: 0.5,
  );
  
  static TextStyle price({Color? color}) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: color ?? AppColors.accent,
    height: 1.3,
  );
  
  static TextStyle rating({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: color ?? AppColors.textPrimary,
    height: 1.3,
  );
  
  // Link Styles
  static TextStyle link({Color? color}) => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.accent,
    height: 1.5,
    decoration: TextDecoration.underline,
    decorationColor: color ?? AppColors.accent,
  );
  
  static TextStyle linkSmall({Color? color}) => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.accent,
    height: 1.4,
    decoration: TextDecoration.underline,
    decorationColor: color ?? AppColors.accent,
  );
}