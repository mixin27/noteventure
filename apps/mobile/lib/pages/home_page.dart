import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:points/points.dart';
import 'package:progress/progress.dart';
import 'package:ui/ui.dart';
import 'package:core/core.dart';
import 'package:notes/notes.dart';

import '../routes/route_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NotesBloc>().add(NotesLoad());
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              title: const Text('Noteventure'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // todo(mixin27): Implement search
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    context.push(RouteConstants.settings);
                  },
                ),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.md),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Points and Level Display
                    BlocBuilder<PointsBloc, PointsState>(
                      builder: (context, state) {
                        final points = state is PointsLoaded
                            ? state.balance
                            : 0;

                        return Row(
                          children: [
                            Expanded(
                              child: PointsDisplay(
                                points: points,
                                isCompact: false,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            BlocBuilder<ProgressBloc, ProgressState>(
                              buildWhen: (previous, current) =>
                                  current is ProgressLoaded,
                              builder: (context, state) {
                                final userProgress = state is ProgressLoaded
                                    ? state.progress
                                    : null;
                                return LevelDisplay(
                                  level: userProgress?.level ?? 0,
                                  isCompact: false,
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // XP Progress
                    BlocBuilder<ProgressBloc, ProgressState>(
                      builder: (context, state) {
                        final userProgress = state is ProgressLoaded
                            ? state.progress
                            : null;

                        return XpProgressBar(
                          currentXp: userProgress?.currentXp ?? 0,
                          xpToNextLevel: userProgress?.xpToNextLevel ?? 0,
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Quick Actions
                    Text('Quick Actions', style: theme.textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                            onTap: () => context.push(RouteConstants.notes),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.note_alt_outlined,
                                  size: AppSpacing.iconLg,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  'Notes',
                                  style: theme.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: CustomCard(
                            onTap: () {
                              context.push(RouteConstants.challenges);
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.psychology_outlined,
                                  size: AppSpacing.iconLg,
                                  color: AppColors.secondary,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  'Challenges',
                                  style: theme.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                            onTap: () {
                              context.push(RouteConstants.achievements);
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.emoji_events_outlined,
                                  size: AppSpacing.iconLg,
                                  color: AppColors.warning,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  'Achievements',
                                  style: theme.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: CustomCard(
                            onTap: () {
                              // todo(mixin27): Navigate to themes
                            },
                            child: Column(
                              children: [
                                Icon(
                                  Icons.palette_outlined,
                                  size: AppSpacing.iconLg,
                                  color: AppColors.accent,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  'Themes',
                                  style: theme.textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(AppSpacing.md),
              sliver: SliverToBoxAdapter(
                child: Text('Recent Notes', style: theme.textTheme.titleLarge),
              ),
            ),

            BlocBuilder<NotesBloc, NotesState>(
              builder: (context, state) {
                if (state is NotesLoading) {
                  return SliverFillRemaining(
                    child: const LoadingIndicator(message: 'Loading notes...'),
                  );
                }

                if (state is NotesError) {
                  return SliverToBoxAdapter(
                    child: CustomErrorWidget(
                      message: state.message,
                      onRetry: () => context.read<NotesBloc>().add(NotesLoad()),
                    ),
                  );
                }

                if (state is NotesLoaded) {
                  if (state.notes.isEmpty) {
                    return SliverToBoxAdapter(
                      child: EmptyState(
                        title: 'No notes yet',
                        message: 'Create your first note to get started!',
                        icon: Icons.note_add_outlined,
                        action: CustomButton(
                          text: 'Create Note',
                          onPressed: () => context.push(RouteConstants.notes),
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    sliver: SliverList.separated(
                      itemCount: state.notes.length > 5
                          ? 5
                          : state.notes.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final note = state.notes[index];
                        return CustomCard(
                          onTap: () {
                            context.push(
                              '${RouteConstants.noteDetail}/${note.id}',
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      note.title,
                                      style: theme.textTheme.titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (note.isPinned)
                                    const Icon(
                                      Icons.push_pin,
                                      size: AppSpacing.iconSm,
                                      color: AppColors.primary,
                                    ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                note.content,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Row(
                                children: [
                                  CustomBadge(
                                    text: note.noteType.displayName,
                                    variant: BadgeVariant.primary,
                                    isSmall: true,
                                  ),
                                  const Spacer(),
                                  Text(
                                    note.updatedAt.timeAgo,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                return SliverToBoxAdapter(child: const LoadingIndicator());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteConstants.noteCreate),
        child: const Icon(Icons.add),
      ),
    );
  }
}
