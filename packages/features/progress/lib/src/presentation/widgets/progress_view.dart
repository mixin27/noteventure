import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../../domain/entities/user_progress.dart';
import '../bloc/progress_bloc.dart';
import '../bloc/progress_event.dart';
import '../bloc/progress_state.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: BlocBuilder<ProgressBloc, ProgressState>(
        builder: (context, state) {
          if (state is ProgressLoading) {
            return const LoadingIndicator(message: 'Loading progress...');
          }

          if (state is ProgressError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<ProgressBloc>().add(LoadUserProgress()),
            );
          }

          if (state is ProgressLoaded || state is ProgressLeveledUp) {
            final progress = state is ProgressLoaded
                ? state.progress
                : (state as ProgressLeveledUp).progress;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Level Display
                  _buildLevelCard(context, progress),
                  const SizedBox(height: AppSpacing.lg),

                  // Streak Card
                  _buildStreakCard(context, progress),
                  const SizedBox(height: AppSpacing.lg),

                  // Stats
                  Text(
                    'Statistics',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  _buildStatsGrid(context, progress),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, UserProgress progress) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  Text(
                    '${progress.level}',
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              LevelDisplay(level: progress.level, isCompact: false),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'XP Progress',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  Text(
                    '${progress.currentXp} / ${progress.xpToNextLevel}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                child: LinearProgressIndicator(
                  value: progress.progressPercentage / 100,
                  minHeight: 12,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, UserProgress progress) {
    final theme = Theme.of(context);
    final hasStreak = progress.currentStreak > 0;

    return CustomCard(
      color: hasStreak
          ? AppColors.warning.withValues(alpha: 0.1)
          : theme.colorScheme.surface,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: hasStreak
                  ? AppColors.warning
                  : theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(
              Icons.local_fire_department,
              color: hasStreak
                  ? Colors.white
                  : theme.colorScheme.onSurfaceVariant,
              size: AppSpacing.iconLg,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Streak',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  progress.currentStreak > 0
                      ? MessageGenerator.getStreakMessage(
                          progress.currentStreak,
                        )
                      : 'Complete a challenge to start your streak!',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                '${progress.currentStreak}',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: hasStreak ? AppColors.warning : null,
                ),
              ),
              Text('days', style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, UserProgress progress) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     Expanded(
        //       child: _buildStatCard(
        //         context,
        //         icon: Icons.emoji_events,
        //         label: 'Total Points',
        //         value: '${progress.lifetimePointsEarned}',
        //         color: AppColors.success,
        //       ),
        //     ),
        //     const SizedBox(width: AppSpacing.md),
        //     Expanded(
        //       child: _buildStatCard(
        //         context,
        //         icon: Icons.trending_up,
        //         label: 'Points Spent',
        //         value: '${progress.lifetimePointsSpent}',
        //         color: AppColors.error,
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.check_circle,
                label: 'Challenges Won',
                value: '${progress.totalChallengesSolved}',
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.cancel,
                label: 'Challenges Failed',
                value: '${progress.totalChallengesFailed}',
                color: AppColors.warning,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.note_add,
                label: 'Notes Created',
                value: '${progress.totalNotesCreated}',
                color: AppColors.info,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                context,
                icon: Icons.delete,
                label: 'Notes Deleted',
                value: '${progress.totalNotesDeleted}',
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _buildLongestStreakCard(context, progress),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: AppSpacing.iconMd),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLongestStreakCard(BuildContext context, UserProgress progress) {
    final theme = Theme.of(context);

    return CustomCard(
      color: AppColors.warning.withValues(alpha: 0.1),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.warning,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: const Icon(
              Icons.whatshot,
              color: Colors.white,
              size: AppSpacing.iconMd,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Longest Streak',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  progress.longestStreak > 0
                      ? 'Your best: ${progress.longestStreak} days!'
                      : 'No streak record yet',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${progress.longestStreak}',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.warning,
            ),
          ),
        ],
      ),
    );
  }
}
