import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';
import 'package:points/points.dart';

import '../../domain/entities/challenge.dart';
import '../bloc/challenge_bloc.dart';
import '../bloc/challenge_event.dart';
import 'challenge_page.dart';

class ChallengesMenuPage extends StatelessWidget {
  const ChallengesMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges'),
        actions: [
          BlocBuilder<PointsBloc, PointsState>(
            builder: (context, state) {
              if (state is PointsLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Center(
                    child: PointsDisplay(
                      points: state.balance,
                      isCompact: true,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Earn Points!',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Complete challenges to earn points and level up',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Quick Challenge
            Text(
              'Quick Challenge',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            CustomCard(
              onTap: () => _startChallenge(context, null, 'easy'),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradient,
                      ),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: const Icon(
                      Icons.bolt,
                      color: Colors.white,
                      size: AppSpacing.iconLg,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Random Challenge',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Get a random challenge to solve',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Challenge Types
            Text(
              'Choose Challenge Type',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            _buildChallengeTypeCard(
              context,
              ChallengeType.math,
              'Math',
              'Solve arithmetic problems',
              Icons.calculate_outlined,
              AppColors.mathChallenge,
            ),
            const SizedBox(height: AppSpacing.md),

            _buildChallengeTypeCard(
              context,
              ChallengeType.trivia,
              'Trivia',
              'Test your general knowledge',
              Icons.lightbulb_outline,
              AppColors.triviaChallenge,
            ),
            const SizedBox(height: AppSpacing.md),

            _buildChallengeTypeCard(
              context,
              ChallengeType.wordGame,
              'Word Game',
              'Unscramble words',
              Icons.abc,
              AppColors.wordGameChallenge,
            ),
            const SizedBox(height: AppSpacing.md),

            _buildChallengeTypeCard(
              context,
              ChallengeType.pattern,
              'Pattern',
              'Find the next number',
              Icons.pattern,
              AppColors.patternChallenge,
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Difficulty Info
            Text(
              'Difficulty Levels',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            _buildDifficultyInfo(
              context,
              'Easy',
              '10 points, 15 XP',
              '30 seconds',
              AppColors.success,
            ),
            const SizedBox(height: AppSpacing.sm),

            _buildDifficultyInfo(
              context,
              'Medium',
              '20 points, 30 XP',
              '45 seconds',
              AppColors.warning,
            ),
            const SizedBox(height: AppSpacing.sm),

            _buildDifficultyInfo(
              context,
              'Hard',
              '35 points, 50 XP',
              '60 seconds',
              AppColors.error,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeTypeCard(
    BuildContext context,
    ChallengeType type,
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return CustomCard(
      onTap: () => _showDifficultySelector(context, type),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: color, size: AppSpacing.iconLg),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  Widget _buildDifficultyInfo(
    BuildContext context,
    String difficulty,
    String reward,
    String time,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text(
              difficulty,
              style: theme.textTheme.titleSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.stars, size: AppSpacing.iconSm),
                    const SizedBox(width: AppSpacing.xs),
                    Text(reward, style: theme.textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(Icons.timer_outlined, size: AppSpacing.iconSm),
                    const SizedBox(width: AppSpacing.xs),
                    Text(time, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDifficultySelector(BuildContext context, ChallengeType type) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Difficulty',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            CustomButton(
              text: 'Easy',
              onPressed: () {
                Navigator.pop(sheetContext);
                _startChallenge(context, type, 'easy');
              },
              fullWidth: true,
              backgroundColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomButton(
              text: 'Medium',
              onPressed: () {
                Navigator.pop(sheetContext);
                _startChallenge(context, type, 'medium');
              },
              fullWidth: true,
              backgroundColor: AppColors.warning,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomButton(
              text: 'Hard',
              onPressed: () {
                Navigator.pop(sheetContext);
                _startChallenge(context, type, 'hard');
              },
              fullWidth: true,
              backgroundColor: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomButton(
              text: 'Cancel',
              onPressed: () => Navigator.pop(sheetContext),
              fullWidth: true,
              variant: ButtonVariant.outlined,
            ),
          ],
        ),
      ),
    );
  }

  void _startChallenge(
    BuildContext context,
    ChallengeType? type,
    String difficulty,
  ) {
    // Generate challenge first
    context.read<ChallengeBloc>().add(
      GenerateNewChallenge(type: type, difficulty: difficulty),
    );

    // Navigate to challenge screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ChallengeBloc>(),
          child: BlocProvider.value(
            value: context.read<PointsBloc>(),
            child: ChallengePage(challengeType: type, difficulty: difficulty),
          ),
        ),
      ),
    );
  }
}
