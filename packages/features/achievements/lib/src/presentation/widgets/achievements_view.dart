import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../../domain/entities/achievement.dart';
import '../bloc/achievements_bloc.dart';
import '../bloc/achievements_event.dart';
import '../bloc/achievements_state.dart';
import 'achievement_card.dart';

class AchievementsView extends StatefulWidget {
  const AchievementsView({super.key});

  @override
  State<AchievementsView> createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Unlocked'),
            Tab(text: 'Locked'),
          ],
        ),
      ),
      body: BlocBuilder<AchievementsBloc, AchievementsState>(
        builder: (context, state) {
          if (state is AchievementsLoading) {
            return const LoadingIndicator(message: 'Loading achievements...');
          }

          if (state is AchievementsError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<AchievementsBloc>().add(LoadAchievements()),
            );
          }

          if (state is AchievementsLoaded) {
            return Column(
              children: [
                _buildProgressHeader(context, state),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildAchievementsList(state.achievements),
                      _buildAchievementsList(state.unlocked),
                      _buildAchievementsList(state.locked),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProgressHeader(BuildContext context, AchievementsLoaded state) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
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
                    'Your Progress',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withValues(alpha: 0.9),
                    ),
                  ),
                  Text(
                    '${state.unlockedCount} / ${state.totalAchievements}',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withValues(alpha: 0.2),
                ),
                child: Center(
                  child: Text(
                    '${state.completionPercentage.toInt()}%',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: LinearProgressIndicator(
              value: state.completionPercentage / 100,
              minHeight: 12,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.onPrimary.withValues(alpha: 0.3),
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsList(List<Achievement> achievements) {
    if (achievements.isEmpty) {
      return const Center(
        child: EmptyState(
          icon: Icons.emoji_events,
          title: 'No achievements here',
          message: 'Keep playing to unlock achievements!',
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: AchievementCard(achievement: achievements[index]),
        );
      },
    );
  }
}
