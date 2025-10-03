import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../domain/entities/achievement.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const AchievementCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomCard(
      color: achievement.isUnlocked
          ? _getRarityColor(achievement.rarity).withValues(alpha: 0.1)
          : theme.colorScheme.surface,
      child: Row(
        children: [
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: achievement.isUnlocked
                  ? _getRarityColor(achievement.rarity)
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              _getIconData(achievement.iconName),
              color: achievement.isUnlocked
                  ? Colors.white
                  : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              size: AppSpacing.iconLg,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        achievement.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: achievement.isUnlocked
                              ? null
                              : theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
                        ),
                      ),
                    ),
                    CustomBadge(
                      text: achievement.rarity.displayName,
                      variant: _getRarityBadgeVariant(achievement.rarity),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  achievement.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: achievement.isUnlocked
                        ? theme.colorScheme.onSurfaceVariant
                        : theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (!achievement.isUnlocked) ...[
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusFull,
                          ),
                          child: LinearProgressIndicator(
                            value: achievement.progressPercentage / 100,
                            minHeight: 6,
                            backgroundColor:
                                theme.colorScheme.surfaceContainerHighest,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        '${achievement.currentProgress}/${achievement.targetValue}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        size: 16,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'Unlocked',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.stars,
                            size: 16,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            '+${achievement.pointReward}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.warning,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getRarityColor(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return Colors.grey;
      case AchievementRarity.rare:
        return AppColors.info;
      case AchievementRarity.epic:
        return AppColors.secondary;
      case AchievementRarity.legendary:
        return AppColors.warning;
    }
  }

  BadgeVariant _getRarityBadgeVariant(AchievementRarity rarity) {
    switch (rarity) {
      case AchievementRarity.common:
        return BadgeVariant.secondary;
      case AchievementRarity.rare:
        return BadgeVariant.info;
      case AchievementRarity.epic:
        return BadgeVariant.primary;
      case AchievementRarity.legendary:
        return BadgeVariant.warning;
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'speed_demon':
        return Icons.speed;
      case 'risk_taker':
        return Icons.casino;
      case 'note_hoarder':
        return Icons.inventory;
      case 'deletion_king':
        return Icons.delete_forever;
      case 'first_challenge':
        return Icons.emoji_events;
      case 'challenge_master':
        return Icons.military_tech;
      case 'first_note':
        return Icons.note_add;
      case 'streak_master':
        return Icons.local_fire_department;
      default:
        return Icons.emoji_events;
    }
  }
}
