import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

class ThemeBuilder {
  ThemeBuilder._();

  /// Builds a custom theme by overlaying custom colors onto the base theme
  /// while preserving all design system properties
  static ThemeData buildCustomTheme({
    required Color primary,
    required Color secondary,
    required Color background,
    required Color surface,
    required bool isDark,
  }) {
    // Generate variants
    final primaryLight = _lighten(primary, 0.2);
    final primaryDark = _darken(primary, 0.2);
    final secondaryLight = _lighten(secondary, 0.2);
    final secondaryDark = _darken(secondary, 0.2);
    final surfaceVariant = isDark
        ? _lighten(surface, 0.1)
        : _darken(surface, 0.05);

    // Text colors based on theme mode
    final textPrimary = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final textSecondary = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final divider = isDark ? AppColors.dividerDark : AppColors.divider;

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,

      // Color Scheme - Use custom colors
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,

        primary: primary,
        onPrimary: isDark ? background : Colors.white,
        primaryContainer: isDark ? primary : primaryLight,
        onPrimaryContainer: isDark ? primaryLight : primaryDark,

        secondary: secondary,
        onSecondary: isDark ? background : Colors.white,
        secondaryContainer: isDark ? secondary : secondaryLight,
        onSecondaryContainer: isDark ? secondaryLight : secondaryDark,

        tertiary: AppColors.accent,
        onTertiary: Colors.white,
        tertiaryContainer: AppColors.accentLight,
        onTertiaryContainer: AppColors.accentDark,

        error: isDark ? AppColors.errorLight : AppColors.error,
        onError: isDark ? background : Colors.white,
        errorContainer: isDark ? AppColors.error : AppColors.errorLight,
        onErrorContainer: isDark ? AppColors.errorLight : AppColors.errorDark,

        surface: surface,
        onSurface: textPrimary,
        surfaceContainerHighest: surfaceVariant,
        onSurfaceVariant: textSecondary,

        outline: divider,
        outlineVariant: isDark
            ? AppColors.surfaceDark3
            : AppColors.surfaceLight3,

        shadow: isDark ? AppColors.shadowDark : AppColors.shadow,
      ),

      scaffoldBackgroundColor: background,

      // App Bar
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: background,
        foregroundColor: textPrimary,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: textPrimary),
      ),

      // Card
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: divider, width: 1),
        ),
        color: surface,
      ),

      // Elevated Button - Use custom primary color
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isDark ? primaryLight : primary,
          foregroundColor: isDark ? background : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: isDark ? primaryLight : primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: AppTextStyles.button,
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: isDark ? primaryLight : primary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: isDark ? primaryLight : primary, width: 1.5),
          textStyle: AppTextStyles.button,
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
          borderSide: BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? primaryLight : primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.errorLight : AppColors.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.errorLight : AppColors.error,
            width: 2,
          ),
        ),
      ),

      // Divider
      dividerTheme: DividerThemeData(color: divider, thickness: 1, space: 1),

      // Text Theme - Keep your existing text styles
      textTheme: isDark
          ? TextTheme(
              displayLarge: AppTextStyles.displayLarge.copyWith(
                color: textPrimary,
              ),
              displayMedium: AppTextStyles.displayMedium.copyWith(
                color: textPrimary,
              ),
              displaySmall: AppTextStyles.displaySmall.copyWith(
                color: textPrimary,
              ),
              headlineLarge: AppTextStyles.headlineLarge.copyWith(
                color: textPrimary,
              ),
              headlineMedium: AppTextStyles.headlineMedium.copyWith(
                color: textPrimary,
              ),
              headlineSmall: AppTextStyles.headlineSmall.copyWith(
                color: textPrimary,
              ),
              titleLarge: AppTextStyles.titleLarge.copyWith(color: textPrimary),
              titleMedium: AppTextStyles.titleMedium.copyWith(
                color: textPrimary,
              ),
              titleSmall: AppTextStyles.titleSmall.copyWith(color: textPrimary),
              bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textPrimary),
              bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textPrimary),
              bodySmall: AppTextStyles.bodySmall.copyWith(color: textSecondary),
              labelLarge: AppTextStyles.labelLarge.copyWith(color: textPrimary),
              labelMedium: AppTextStyles.labelMedium.copyWith(
                color: textSecondary,
              ),
              labelSmall: AppTextStyles.labelSmall.copyWith(
                color: AppColors.textTertiaryDark,
              ),
            )
          : const TextTheme(
              displayLarge: AppTextStyles.displayLarge,
              displayMedium: AppTextStyles.displayMedium,
              displaySmall: AppTextStyles.displaySmall,
              headlineLarge: AppTextStyles.headlineLarge,
              headlineMedium: AppTextStyles.headlineMedium,
              headlineSmall: AppTextStyles.headlineSmall,
              titleLarge: AppTextStyles.titleLarge,
              titleMedium: AppTextStyles.titleMedium,
              titleSmall: AppTextStyles.titleSmall,
              bodyLarge: AppTextStyles.bodyLarge,
              bodyMedium: AppTextStyles.bodyMedium,
              bodySmall: AppTextStyles.bodySmall,
              labelLarge: AppTextStyles.labelLarge,
              labelMedium: AppTextStyles.labelMedium,
              labelSmall: AppTextStyles.labelSmall,
            ),

      // Icon Theme
      iconTheme: IconThemeData(color: textPrimary, size: 24),

      // Floating Action Button
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: isDark ? primaryLight : primary,
        foregroundColor: isDark ? background : Colors.white,
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVariant,
        deleteIconColor: textSecondary,
        labelStyle: AppTextStyles.labelMedium.copyWith(color: textPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: isDark ? surface : background,
      ),

      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        backgroundColor: isDark ? surface : background,
      ),

      // Snackbar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: isDark
            ? AppColors.surfaceLight2
            : AppColors.surfaceDark,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: isDark ? AppColors.textPrimaryLight : Colors.white,
        ),
      ),
    );
  }

  static Color _lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }

  static Color _darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }
}
