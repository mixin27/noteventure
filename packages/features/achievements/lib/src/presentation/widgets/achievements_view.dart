import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../../domain/entities/achievement.dart';
import '../bloc/achievements_bloc.dart';
import '../bloc/achievements_event.dart';
import '../bloc/achievements_state.dart';

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
    // final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
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
                children: [Text("TEST LEFT")],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("TEST RIGHT")],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsList(List<Achievement> achievements) {
    return Center(child: Text("achievements list"));
  }
}
