import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/ui.dart' as ui;

import '../domain/entities/app_theme.dart';

extension AppThemeX on AppTheme {
  ThemeData toCustomLightTheme() {
    final primary = primaryColorValue;
    final secondary = secondaryColorValue;
    final background = backgroundColorValue;
    final surface = surfaceColorValue;

    // Generate lighter/darker variants
    final primaryLight = _lighten(primary, 0.2);
    final primaryDark = _darken(primary, 0.2);
    final secondaryLight = _lighten(secondary, 0.2);
    final secondaryDark = _darken(secondary, 0.2);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: primary,
        onPrimary: Colors.white,
        primaryContainer: primaryLight,
        onPrimaryContainer: primaryDark,

        secondary: secondary,
        onSecondary: Colors.white,
        secondaryContainer: secondaryLight,
        onSecondaryContainer: secondaryDark,

        tertiary: ui.AppColors.accent,
        onTertiary: Colors.white,
        tertiaryContainer: ui.AppColors.accentLight,
        onTertiaryContainer: ui.AppColors.accentDark,

        error: ui.AppColors.error,
        onError: Colors.white,
        errorContainer: ui.AppColors.errorLight,
        onErrorContainer: ui.AppColors.errorDark,

        surface: surface,
        onSurface: ui.AppColors.textPrimaryLight,
        surfaceContainerHighest: _darken(surface, 0.05),
        onSurfaceVariant: ui.AppColors.textSecondaryLight,

        outline: ui.AppColors.divider,
        outlineVariant: _darken(surface, 0.1),

        shadow: ui.AppColors.shadow,
      ),

      scaffoldBackgroundColor: background,

      // App Bar
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: background,
        foregroundColor: ui.AppColors.textPrimaryLight,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: const TextStyle(
          color: ui.AppColors.textPrimaryLight,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: ui.AppColors.textPrimaryLight),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: ui.AppColors.divider, width: 1),
        ),
        color: surface,
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: ui.AppTextStyles.button,
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: ui.AppTextStyles.button,
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: primary, width: 1.5),
          textStyle: ui.AppTextStyles.button,
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ui.AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ui.AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ui.AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ui.AppColors.error, width: 2),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: ui.AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: ui.AppTextStyles.displayLarge,
        displayMedium: ui.AppTextStyles.displayMedium,
        displaySmall: ui.AppTextStyles.displaySmall,
        headlineLarge: ui.AppTextStyles.headlineLarge,
        headlineMedium: ui.AppTextStyles.headlineMedium,
        headlineSmall: ui.AppTextStyles.headlineSmall,
        titleLarge: ui.AppTextStyles.titleLarge,
        titleMedium: ui.AppTextStyles.titleMedium,
        titleSmall: ui.AppTextStyles.titleSmall,
        bodyLarge: ui.AppTextStyles.bodyLarge,
        bodyMedium: ui.AppTextStyles.bodyMedium,
        bodySmall: ui.AppTextStyles.bodySmall,
        labelLarge: ui.AppTextStyles.labelLarge,
        labelMedium: ui.AppTextStyles.labelMedium,
        labelSmall: ui.AppTextStyles.labelSmall,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: ui.AppColors.textPrimaryLight,
        size: 24,
      ),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: _darken(surface, 0.05),
        deleteIconColor: ui.AppColors.textSecondaryLight,
        labelStyle: ui.AppTextStyles.labelMedium.copyWith(
          color: ui.AppColors.textPrimaryLight,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: background,
      ),

      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        backgroundColor: background,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: ui.AppColors.surfaceDark,
        contentTextStyle: ui.AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  ThemeData toCustomDarkTheme() {
    final primary = primaryColorValue;
    final secondary = secondaryColorValue;
    final background = backgroundColorValue;
    final surface = surfaceColorValue;

    // Generate lighter variants for dark theme
    final primaryLight = _lighten(primary, 0.3);
    final secondaryLight = _lighten(secondary, 0.3);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      colorScheme: ColorScheme.dark(
        primary: primaryLight,
        onPrimary: background,
        primaryContainer: primary,
        onPrimaryContainer: primaryLight,

        secondary: secondaryLight,
        onSecondary: background,
        secondaryContainer: secondary,
        onSecondaryContainer: secondaryLight,

        tertiary: ui.AppColors.accentLight,
        onTertiary: background,
        tertiaryContainer: ui.AppColors.accent,
        onTertiaryContainer: ui.AppColors.accentLight,

        error: ui.AppColors.errorLight,
        onError: background,
        errorContainer: ui.AppColors.error,
        onErrorContainer: ui.AppColors.errorLight,

        surface: surface,
        onSurface: ui.AppColors.textPrimaryDark,
        surfaceContainerHighest: _lighten(surface, 0.1),
        onSurfaceVariant: ui.AppColors.textSecondaryDark,

        outline: ui.AppColors.dividerDark,
        outlineVariant: _lighten(surface, 0.15),

        shadow: ui.AppColors.shadowDark,
      ),

      scaffoldBackgroundColor: background,

      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: background,
        foregroundColor: ui.AppColors.textPrimaryDark,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: const TextStyle(
          color: ui.AppColors.textPrimaryDark,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: ui.AppColors.textPrimaryDark),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: ui.AppColors.dividerDark, width: 1),
        ),
        color: surface,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryLight,
          foregroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: ui.AppTextStyles.button,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: ui.AppTextStyles.button,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: primaryLight, width: 1.5),
          textStyle: ui.AppTextStyles.button,
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ui.AppColors.dividerDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ui.AppColors.dividerDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ui.AppColors.errorLight),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ui.AppColors.errorLight,
            width: 2,
          ),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: ui.AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      textTheme: TextTheme(
        displayLarge: ui.AppTextStyles.displayLarge.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        displayMedium: ui.AppTextStyles.displayMedium.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        displaySmall: ui.AppTextStyles.displaySmall.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        headlineLarge: ui.AppTextStyles.headlineLarge.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        headlineMedium: ui.AppTextStyles.headlineMedium.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        headlineSmall: ui.AppTextStyles.headlineSmall.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        titleLarge: ui.AppTextStyles.titleLarge.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        titleMedium: ui.AppTextStyles.titleMedium.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        titleSmall: ui.AppTextStyles.titleSmall.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        bodyLarge: ui.AppTextStyles.bodyLarge.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        bodyMedium: ui.AppTextStyles.bodyMedium.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        bodySmall: ui.AppTextStyles.bodySmall.copyWith(
          color: ui.AppColors.textSecondaryDark,
        ),
        labelLarge: ui.AppTextStyles.labelLarge.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        labelMedium: ui.AppTextStyles.labelMedium.copyWith(
          color: ui.AppColors.textSecondaryDark,
        ),
        labelSmall: ui.AppTextStyles.labelSmall.copyWith(
          color: ui.AppColors.textTertiaryDark,
        ),
      ),

      iconTheme: const IconThemeData(
        color: ui.AppColors.textPrimaryDark,
        size: 24,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: primaryLight,
        foregroundColor: background,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: _lighten(surface, 0.1),
        deleteIconColor: ui.AppColors.textSecondaryDark,
        labelStyle: ui.AppTextStyles.labelMedium.copyWith(
          color: ui.AppColors.textPrimaryDark,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      dialogTheme: DialogThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: surface,
      ),

      bottomSheetTheme: BottomSheetThemeData(
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        backgroundColor: surface,
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: ui.AppColors.surfaceLight2,
        contentTextStyle: ui.AppTextStyles.bodyMedium.copyWith(
          color: ui.AppColors.textPrimaryLight,
        ),
      ),
    );
  }

  // Helper methods to lighten/darken colors
  Color _lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }
}
