import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_spacing.dart';

enum BadgeVariant { primary, secondary, success, warning, error, info }

class CustomBadge extends StatelessWidget {
  final String text;
  final BadgeVariant variant;
  final bool isSmall;

  const CustomBadge({
    super.key,
    required this.text,
    this.variant = BadgeVariant.primary,
    this.isSmall = false,
  });

  Color _getBackgroundColor() {
    return switch (variant) {
      BadgeVariant.primary => AppColors.primary.withValues(alpha: 0.1),
      BadgeVariant.secondary => AppColors.secondary.withValues(alpha: 0.1),
      BadgeVariant.success => AppColors.success.withValues(alpha: 0.1),
      BadgeVariant.warning => AppColors.warning.withValues(alpha: 0.1),
      BadgeVariant.error => AppColors.error.withValues(alpha: 0.1),
      BadgeVariant.info => AppColors.info.withValues(alpha: 0.1),
    };
  }

  Color _getTextColor() {
    return switch (variant) {
      BadgeVariant.primary => AppColors.primary,
      BadgeVariant.secondary => AppColors.secondary,
      BadgeVariant.success => AppColors.success,
      BadgeVariant.warning => AppColors.warning,
      BadgeVariant.error => AppColors.error,
      BadgeVariant.info => AppColors.info,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? AppSpacing.sm : AppSpacing.md,
        vertical: isSmall ? AppSpacing.xs / 2 : AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSmall ? 10 : 12,
          fontWeight: FontWeight.w600,
          color: _getTextColor(),
        ),
      ),
    );
  }
}
