import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);

  // Secondary Colors
  static const Color secondary = Color(0xFF8B5CF6); // Purple
  static const Color secondaryLight = Color(0xFFA78BFA);
  static const Color secondaryDark = Color(0xFF7C3AED);

  // Accent Colors
  static const Color accent = Color(0xFFEC4899); // Pink
  static const Color accentLight = Color(0xFFF472B6);
  static const Color accentDark = Color(0xFFDB2777);

  // Success, Warning, Error
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);

  // Neutral Colors (Light Theme)
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF9FAFB);
  static const Color surfaceLight2 = Color(0xFFF3F4F6);
  static const Color surfaceLight3 = Color(0xFFE5E7EB);

  // Neutral Colors (Dark Theme)
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceDark2 = Color(0xFF334155);
  static const Color surfaceDark3 = Color(0xFF475569);

  // Text Colors (Light Theme)
  static const Color textPrimaryLight = Color(0xFF1F2937);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textTertiaryLight = Color(0xFF9CA3AF);

  // Text Colors (Dark Theme)
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFD1D5DB);
  static const Color textTertiaryDark = Color(0xFF9CA3AF);

  // Special Colors
  static const Color divider = Color(0xFFE5E7EB);
  static const Color dividerDark = Color(0xFF374151);

  static const Color shadow = Color(0x1A000000);
  static const Color shadowDark = Color(0x33000000);

  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
  ];

  static const List<Color> accentGradient = [
    Color(0xFFEC4899),
    Color(0xFFF59E0B),
  ];

  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF3B82F6),
  ];

  // Challenge Type Colors
  static const Color mathChallenge = Color(0xFF3B82F6);
  static const Color triviaChallenge = Color(0xFF8B5CF6);
  static const Color wordGameChallenge = Color(0xFFEC4899);
  static const Color patternChallenge = Color(0xFF10B981);
  static const Color riddleChallenge = Color(0xFFF59E0B);

  // Rarity Colors
  static const Color rarityCommon = Color(0xFF6B7280);
  static const Color rarityRare = Color(0xFF3B82F6);
  static const Color rarityEpic = Color(0xFF8B5CF6);
  static const Color rarityLegendary = Color(0xFFF59E0B);

  // Note Type Colors
  static const Color noteStandard = Color(0xFF6366F1);
  static const Color noteVault = Color(0xFFF59E0B);
  static const Color noteMystery = Color(0xFF8B5CF6);
  static const Color noteTimeCapsule = Color(0xFF3B82F6);
  static const Color noteChallenge = Color(0xFFEC4899);
}
