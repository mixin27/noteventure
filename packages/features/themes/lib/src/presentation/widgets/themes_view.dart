import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:points/points.dart';
import 'package:themes/src/presentation/bloc/themes_event.dart';
import 'package:ui/ui.dart' as ui;

import '../../domain/entities/app_theme.dart';
import '../bloc/themes_bloc.dart';
import '../bloc/themes_state.dart';
import 'theme_card.dart';

class ThemesView extends StatefulWidget {
  const ThemesView({super.key});

  @override
  State<ThemesView> createState() => _ThemesViewState();
}

class _ThemesViewState extends State<ThemesView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Shop'),
        actions: [
          BlocBuilder<PointsBloc, PointsState>(
            builder: (context, state) {
              if (state is PointsLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: ui.AppSpacing.md,
                  ),
                  child: Center(
                    child: ui.PointsDisplay(
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All Themes'),
            Tab(text: 'Unlocked'),
          ],
        ),
      ),
      body: BlocBuilder<ThemesBloc, ThemesState>(
        builder: (context, state) {
          if (state is ThemesLoading) {
            return const ui.LoadingIndicator(message: 'Loading themes...');
          }

          if (state is ThemesError) {
            return ui.CustomErrorWidget(
              message: state.message,
              onRetry: () => context.read<ThemesBloc>().add(LoadThemes()),
            );
          }

          if (state is ThemesLoaded) {
            return Column(
              children: [
                _buildActiveThemeHeader(context, state),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildThemesList(state.themes, state.activeTheme),
                      _buildThemesList(state.unlocked, state.activeTheme),
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

  Widget _buildActiveThemeHeader(BuildContext context, ThemesLoaded state) {
    final theme = Theme.of(context);
    final activeTheme = state.activeTheme;

    if (activeTheme == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(ui.AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            activeTheme.primaryColorValue,
            activeTheme.secondaryColorValue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(ui.AppSpacing.radiusMd),
            ),
            child: const Icon(
              Icons.palette,
              color: Colors.white,
              size: ui.AppSpacing.iconLg,
            ),
          ),
          const SizedBox(width: ui.AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Active Theme',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                Text(
                  activeTheme.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ui.CustomBadge(text: 'Active', variant: ui.BadgeVariant.success),
        ],
      ),
    );
  }

  Widget _buildThemesList(List<AppTheme> themes, AppTheme? activeTheme) {
    if (themes.isEmpty) {
      return const Center(
        child: ui.EmptyState(
          icon: Icons.palette,
          title: 'No themes here',
          message: 'Unlock themes by earning points!',
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(ui.AppSpacing.md),
      itemCount: themes.length,
      itemBuilder: (context, index) {
        final theme = themes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: ui.AppSpacing.md),
          child: ThemeCard(
            theme: theme,
            isActive: activeTheme?.themeKey == theme.themeKey,
          ),
        );
      },
    );
  }
}
