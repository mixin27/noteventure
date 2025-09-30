import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';
import 'package:core/core.dart';
import 'package:notes/notes.dart';
import '../di/injection.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotesBloc>()..add(NotesLoad()),
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
      body: BlocConsumer<NotesBloc, NotesState>(
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
          } else if (state is NotesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // todo(mixin27): Show create note dialog
          _showCreateNoteDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('New Note'),
      ),
    );
  }

  void _showCreateNoteDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter note title',
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                hintText: 'Enter note content',
              ),
              maxLines: 5,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          CustomButton(
            text: 'Create',
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                context.read<NotesBloc>().add(
                  NoteCreate(
                    title: titleController.text,
                    content: contentController.text,
                  ),
                );
                Navigator.of(dialogContext).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
