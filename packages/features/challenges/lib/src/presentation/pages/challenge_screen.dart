import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';
import 'package:core/core.dart';
import 'package:points/points.dart';

import '../../domain/entities/challenge.dart';
import '../bloc/challenge_bloc.dart';
import '../bloc/challenge_event.dart';
import '../bloc/challenge_state.dart';

class ChallengeScreen extends StatefulWidget {
  final ChallengeType? challengeType;
  final String? difficulty;

  const ChallengeScreen({super.key, this.challengeType, this.difficulty});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final TextEditingController _answerController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 0;

  @override
  void dispose() {
    _timer?.cancel();
    _answerController.dispose();
    super.dispose();
  }

  void _startTimer(int timeLimit) {
    _timer?.cancel();
    setState(() => _secondsRemaining = timeLimit);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
        _handleTimeout();
      }
    });
  }

  void _handleTimeout() {
    if (mounted) {
      context.read<ChallengeBloc>().add(
        SubmitChallengeAnswer(_answerController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge'),
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
      body: BlocConsumer<ChallengeBloc, ChallengeState>(
        listener: (context, state) {
          if (state is ChallengeReady) {
            _answerController.clear();
            _startTimer(state.challenge.timeLimit);
          } else if (state is ChallengeCorrect || state is ChallengeIncorrect) {
            _timer?.cancel();
          }
        },
        builder: (context, state) {
          if (state is ChallengeInitial || state is ChallengeLoading) {
            return const LoadingIndicator(message: 'Generating challenge...');
          }

          if (state is ChallengeError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => context.read<ChallengeBloc>().add(
                GenerateNewChallenge(
                  type: widget.challengeType,
                  difficulty: widget.difficulty,
                ),
              ),
            );
          }

          if (state is ChallengeReady) {
            return _buildChallengeContent(state.challenge);
          }

          if (state is ChallengeCorrect) {
            return _buildSuccessContent(state);
          }

          if (state is ChallengeIncorrect) {
            return _buildFailureContent(state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildChallengeContent(Challenge challenge) {
    final theme = Theme.of(context);
    final progress = _secondsRemaining / challenge.timeLimit;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timer
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: _getTimerColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(
                color: _getTimerColor().withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer_outlined, color: _getTimerColor()),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Time Remaining',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: _getTimerColor(),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$_secondsRemaining',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getTimerColor(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation(_getTimerColor()),
                  minHeight: 8,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Challenge info
          Row(
            children: [
              CustomBadge(
                text: challenge.type.displayName,
                variant: BadgeVariant.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              CustomBadge(
                text: challenge.difficulty.capitalize,
                variant: BadgeVariant.secondary,
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(
                    Icons.stars,
                    size: AppSpacing.iconSm,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '+${challenge.pointReward}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Question
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Text(
              challenge.question,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Answer input
          if (challenge.options != null)
            _buildMultipleChoiceOptions(challenge.options!)
          else
            _buildTextInput(theme),
        ],
      ),
    );
  }

  Widget _buildTextInput(ThemeData theme) {
    return Column(
      children: [
        TextField(
          controller: _answerController,
          decoration: const InputDecoration(
            labelText: 'Your Answer',
            hintText: 'Type your answer here',
            prefixIcon: Icon(Icons.edit),
          ),
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
          autofocus: true,
          onSubmitted: (value) {
            context.read<ChallengeBloc>().add(SubmitChallengeAnswer(value));
          },
        ),
        const SizedBox(height: AppSpacing.xl),
        CustomButton(
          text: 'Submit Answer',
          onPressed: () {
            context.read<ChallengeBloc>().add(
              SubmitChallengeAnswer(_answerController.text),
            );
          },
          fullWidth: true,
          icon: const Icon(Icons.check, size: AppSpacing.iconSm),
        ),
      ],
    );
  }

  Widget _buildMultipleChoiceOptions(List<String> options) {
    return Column(
      children: options.map((option) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: CustomButton(
            text: option,
            onPressed: () {
              context.read<ChallengeBloc>().add(SubmitChallengeAnswer(option));
            },
            fullWidth: true,
            variant: ButtonVariant.outlined,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSuccessContent(ChallengeCorrect state) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BounceAnimation(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: AppColors.successGradient,
                  ),
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Correct!',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              state.message,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.stars,
                            color: AppColors.warning,
                            size: AppSpacing.iconLg,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            '+${state.pointsEarned}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.warning,
                            ),
                          ),
                          Text(
                            'Points',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 60,
                        color: theme.colorScheme.outline,
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.trending_up,
                            color: AppColors.info,
                            size: AppSpacing.iconLg,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            '+${state.xpEarned}',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.info,
                            ),
                          ),
                          Text(
                            'XP',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Another Challenge',
                    onPressed: () {
                      context.read<ChallengeBloc>().add(
                        GenerateNewChallenge(
                          type: state.challenge.type,
                          difficulty: state.challenge.difficulty,
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh, size: AppSpacing.iconSm),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: CustomButton(
                    text: 'Done',
                    onPressed: () => Navigator.of(context).pop(),
                    variant: ButtonVariant.outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFailureContent(ChallengeIncorrect state) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.error.withValues(alpha: 0.1),
                border: Border.all(color: AppColors.error, width: 4),
              ),
              child: const Icon(Icons.close, size: 64, color: AppColors.error),
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Incorrect',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              state.message,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Your Answer',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    state.userAnswer.isEmpty ? '(No answer)' : state.userAnswer,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Correct Answer',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    state.correctAnswer,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Try Again',
                    onPressed: () {
                      context.read<ChallengeBloc>().add(
                        GenerateNewChallenge(
                          type: state.challenge.type,
                          difficulty: state.challenge.difficulty,
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh, size: AppSpacing.iconSm),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: CustomButton(
                    text: 'Done',
                    onPressed: () => Navigator.of(context).pop(),
                    variant: ButtonVariant.outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTimerColor() {
    if (_secondsRemaining <= 5) {
      return AppColors.error;
    } else if (_secondsRemaining <= 10) {
      return AppColors.warning;
    } else {
      return AppColors.success;
    }
  }
}
