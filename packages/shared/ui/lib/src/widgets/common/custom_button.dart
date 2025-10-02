import 'package:flutter/material.dart';

import '../../themes/app_spacing.dart';

enum ButtonSize { small, medium, large }

enum ButtonVariant { filled, outlined, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final Widget? icon;
  final bool isLoading;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.filled,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Button padding based on size
    final padding = switch (size) {
      ButtonSize.small => const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      ButtonSize.medium => const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      ButtonSize.large => const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
    };

    // Button height based on size
    final height = switch (size) {
      ButtonSize.small => 32.0,
      ButtonSize.medium => 44.0,
      ButtonSize.large => 56.0,
    };

    Widget buttonChild = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(
                foregroundColor ?? theme.colorScheme.onPrimary,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(child: Text(text, textAlign: TextAlign.center)),
            ],
          );

    final button = switch (variant) {
      ButtonVariant.filled => ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding,
          minimumSize: Size(fullWidth ? double.infinity : 0, height),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
        ),
        child: buttonChild,
      ),
      ButtonVariant.outlined => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding,
          minimumSize: Size(fullWidth ? double.infinity : 0, height),
          foregroundColor: foregroundColor ?? theme.colorScheme.primary,
          side: BorderSide(
            color: backgroundColor ?? theme.colorScheme.primary,
            width: 1.5,
          ),
        ),
        child: buttonChild,
      ),
      ButtonVariant.text => TextButton(
        onPressed: isLoading ? null : onPressed,
        style: TextButton.styleFrom(
          padding: padding,
          minimumSize: Size(fullWidth ? double.infinity : 0, height),
          foregroundColor: foregroundColor ?? theme.colorScheme.primary,
        ),
        child: buttonChild,
      ),
    };
    return button;
  }
}
