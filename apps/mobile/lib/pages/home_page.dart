import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';
import 'package:core/core.dart';
import 'package:notes/notes.dart';
import '../routes/route_constants.dart';
import '../di/injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotesBloc>()..add(NotesLoad()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
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
              // todo(mixin27): Implement settings
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Points and Level Display
            Row(
              children: [
                Expanded(
                  child: PointsDisplay(
                    points: 100, // todo(mixin27): Get from PointsBloc
                    isCompact: false,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                LevelDisplay(
                  level: 1, // todo(mixin27): Get from ProgressBloc
                  isCompact: false,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // XP Progress
            XpProgressBar(
              currentXp: 50, // todo(mixin27): Get from ProgressBloc
              xpToNextLevel: 100,
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
                        Text('Notes', style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: CustomCard(
                    onTap: () {
                      // todo(mixin27): Navigate to challenges
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.psychology_outlined,
                          size: AppSpacing.iconLg,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text('Challenges', style: theme.textTheme.titleMedium),
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
                      // todo(mixin27): Navigate to achievements
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
                        Text('Themes', style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Recent Notes
            Text('Recent Notes', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  if (state is NotesLoading) {
                    return const LoadingIndicator(message: 'Loading notes...');
                  }

                  if (state is NotesError) {
                    return CustomErrorWidget(
                      message: state.message,
                      onRetry: () => context.read<NotesBloc>().add(NotesLoad()),
                    );
                  }

                  if (state is NotesLoaded) {
                    if (state.notes.isEmpty) {
                      return SingleChildScrollView(
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

                    return ListView.separated(
                      itemCount: state.notes.length > 5
                          ? 5
                          : state.notes.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final note = state.notes[index];
                        return CustomCard(
                          onTap: () {
                            // todo(mixin27): Navigate to note detail
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
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(RouteConstants.notes),
        child: const Icon(Icons.add),
      ),
    );
  }
}
