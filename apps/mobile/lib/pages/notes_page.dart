import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:points/points.dart';
import 'package:ui/ui.dart';
import 'package:core/core.dart';
import 'package:notes/notes.dart';

import '../di/injection.dart';
import '../routes/route_constants.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<PointsBloc>()..add(LoadPointBalance()),
        ),
        BlocProvider(create: (_) => getIt<NotesBloc>()..add(NotesLoad())),
      ],
      child: const NotesView(),
    );
  }
}

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          // Points display in app bar
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
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // todo(mixin27): Implement search
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'all':
                  context.read<NotesBloc>().add(NotesLoad());
                  break;
                case 'pinned':
                  context.read<NotesBloc>().add(PinnedNotesLoad());
                  break;
                case 'favorites':
                  context.read<NotesBloc>().add(FavoriteNotesLoad());
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'all', child: Text('All Notes')),
              const PopupMenuItem(value: 'pinned', child: Text('Pinned')),
              const PopupMenuItem(value: 'favorites', child: Text('Favorites')),
            ],
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<NotesBloc, NotesState>(
            listener: (context, state) {
              if (state is NoteCreated) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is NoteDeleted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is NoteToggled) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is NoteActionRequiresChallenge) {
                // Show dialog about insufficient points
                _showInsufficientPointsDialog(context, state);
                context.read<NotesBloc>().add(NotesLoad());
              } else if (state is NotesError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.error,
                  ),
                );
              }
            },
          ),
          BlocListener<PointsBloc, PointsState>(
            listener: (context, state) {
              if (state is PointsSpent) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.amountSpent} points spent'),
                    backgroundColor: AppColors.warning,
                  ),
                );
              } else if (state is PointsEarned) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.amountEarned} points earned!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            },
          ),
        ],
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
                return EmptyState(
                  title: 'No notes yet',
                  message: 'Tap the + button to create your first note!',
                  icon: Icons.note_add_outlined,
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<NotesBloc>().add(NotesRefresh());
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  itemCount: state.notes.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final note = state.notes[index];
                    return FadeInAnimation(
                      delay: Duration(milliseconds: 50 * index),
                      child: CustomCard(
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
                                    style: theme.textTheme.titleLarge,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    note.isPinned
                                        ? Icons.push_pin
                                        : Icons.push_pin_outlined,
                                    color: note.isPinned
                                        ? AppColors.primary
                                        : null,
                                  ),
                                  onPressed: () {
                                    context.read<NotesBloc>().add(
                                      PinNoteToggle(note.id),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    note.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: note.isFavorite
                                        ? AppColors.error
                                        : null,
                                  ),
                                  onPressed: () {
                                    context.read<NotesBloc>().add(
                                      FavoriteNoteToggle(note.id),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              note.content,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Row(
                              children: [
                                CustomBadge(
                                  text: note.noteType.displayName,
                                  variant: BadgeVariant.primary,
                                  isSmall: true,
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                CustomBadge(
                                  text: '${note.editCount} edits',
                                  variant: BadgeVariant.secondary,
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
                      ),
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(RouteConstants.noteCreate);
        },
        icon: const Icon(Icons.add),
        label: const Text('New Note'),
      ),
    );
  }

  void _showInsufficientPointsDialog(
    BuildContext context,
    NoteActionRequiresChallenge state,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.warning),
            const SizedBox(width: AppSpacing.sm),
            const Text('Insufficient Points'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You need ${state.pointCost} points to ${state.action} this note.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current Balance:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                PointsDisplay(points: state.currentPoints, isCompact: true),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Required:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${state.pointCost} points',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shortfall:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${state.pointCost - state.currentPoints} points',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(
                  color: AppColors.info.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.info,
                    size: AppSpacing.iconSm,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Complete challenges to earn points!',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.info),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          CustomButton(
            text: 'Earn Points',
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.push(RouteConstants.challenges);
            },
            icon: const Icon(
              Icons.psychology_outlined,
              size: AppSpacing.iconSm,
            ),
          ),
        ],
      ),
    );
  }
}
