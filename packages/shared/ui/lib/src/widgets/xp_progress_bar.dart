import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../themes/app_colors.dart';
import '../themes/app_spacing.dart';

class XpProgressBar extends StatelessWidget {
  final int currentXp;
  final int xpToNextLevel;
  final bool showLabel;
  final double height;

  const XpProgressBar({
    super.key,
    required this.currentXp,
    required this.xpToNextLevel,
    this.showLabel = true,
    this.height = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = xpToNextLevel > 0 ? currentXp / xpToNextLevel : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('XP Progress', style: theme.textTheme.labelMedium),
              Text(
                '${currentXp.formatted} / ${xpToNextLevel.formatted}',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: height,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            valueColor: const AlwaysStoppedAnimation(AppColors.success),
          ),
        ),
      ],
    );
  }
}
