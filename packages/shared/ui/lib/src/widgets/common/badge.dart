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

  Color _getBackgroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (variant) {
      BadgeVariant.primary => colorScheme.primary.withValues(alpha: 0.1),
      BadgeVariant.secondary => colorScheme.secondary.withValues(alpha: 0.1),
      BadgeVariant.success => AppColors.success.withValues(alpha: 0.1),
      BadgeVariant.warning => AppColors.warning.withValues(alpha: 0.1),
      BadgeVariant.error => colorScheme.error.withValues(alpha: 0.1),
      BadgeVariant.info => AppColors.info.withValues(alpha: 0.1),
    };
  }

  Color _getTextColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (variant) {
      BadgeVariant.primary => colorScheme.primary,
      BadgeVariant.secondary => colorScheme.secondary,
      BadgeVariant.success => AppColors.success,
      BadgeVariant.warning => AppColors.warning,
      BadgeVariant.error => colorScheme.error,
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
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isSmall ? 10 : 12,
          fontWeight: FontWeight.w600,
          color: _getTextColor(context),
        ),
      ),
    );
  }
}
