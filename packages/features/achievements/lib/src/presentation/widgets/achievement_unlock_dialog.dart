import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../domain/entities/achievement.dart';

class AchievementUnlockDialog extends StatelessWidget {
  final Achievement achievement;

  const AchievementUnlockDialog({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BounceAnimation(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getRarityColor(achievement.rarity),
              ),
              child: Icon(
                _getIconData(achievement.iconName),
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Achievement Unlocked!',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            achievement.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: _getRarityColor(achievement.rarity),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            achievement.description,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(
                color: AppColors.warning.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.stars, color: AppColors.warning),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '+${achievement.pointReward} Points',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        CustomButton(
          text: 'Awesome!',
          onPressed: () => Navigator.of(context).pop(),
          fullWidth: true,
        ),
      ],
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
