import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:points/points.dart';
import 'package:ui/ui.dart';

import '../../domain/entities/note.dart';
import '../bloc/notes_bloc.dart';
import '../bloc/notes_event.dart';
import '../bloc/notes_state.dart';
import 'note_editor_page.dart';

class NoteDetailPage extends StatelessWidget {
  final int noteId;

  const NoteDetailPage({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        // Try to find the note in current state
        Note? note;
        if (state is NotesLoaded) {
          try {
            note = state.notes.firstWhere((n) => n.id == noteId);
          } catch (_) {
            // Note not found
          }
        }

        if (note == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Note')),
            body: const Center(child: Text('Note not found')),
          );
        }

        return NoteDetailView(note: note);
      },
    );
  }
}

class NoteDetailView extends StatelessWidget {
  final Note note;

  const NoteDetailView({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Details'),
        actions: [
          // Points display
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
          // Edit button
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _handleEdit(context),
          ),
          // More options
          PopupMenuButton<String>(
            onSelected: (value) => _handleMenuAction(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'pin',
                child: Row(
                  children: [
                    Icon(
                      note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      size: AppSpacing.iconSm,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(note.isPinned ? 'Unpin' : 'Pin'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'favorite',
                child: Row(
                  children: [
                    Icon(
                      note.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: AppSpacing.iconSm,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      note.isFavorite
                          ? 'Remove from favorites'
                          : 'Add to favorites',
                    ),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      size: AppSpacing.iconSm,
                      color: AppColors.error,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    Text('Delete', style: TextStyle(color: AppColors.error)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              note.title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Metadata
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                CustomBadge(
                  text: note.noteType.displayName,
                  variant: _getBadgeVariant(note.noteType),
                ),
                if (note.isPinned)
                  const CustomBadge(
                    text: 'Pinned',
                    variant: BadgeVariant.primary,
                  ),
                if (note.isFavorite)
                  const CustomBadge(
                    text: 'Favorite',
                    variant: BadgeVariant.error,
                  ),
                CustomBadge(
                  text: '${note.editCount} edits',
                  variant: BadgeVariant.secondary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Divider
            Divider(color: theme.colorScheme.outline),
            const SizedBox(height: AppSpacing.lg),

            // Content
            Text(
              note.content,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Info section
            CustomCard(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.3,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Information',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildInfoRow(
                    context,
                    'Created',
                    note.createdAt.formattedDateTime,
                    Icons.calendar_today_outlined,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildInfoRow(
                    context,
                    'Last Updated',
                    note.updatedAt.formattedDateTime,
                    Icons.update_outlined,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildInfoRow(
                    context,
                    'Time Ago',
                    note.updatedAt.timeAgo,
                    Icons.access_time_outlined,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _buildInfoRow(
                    context,
                    'Edit Count',
                    '${note.editCount} times',
                    Icons.edit_outlined,
                  ),
                  if (note.isLocked) ...[
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(
                      context,
                      'Status',
                      'Locked',
                      Icons.lock_outlined,
                      valueColor: AppColors.error,
                    ),
                  ],
                  if (note.unlockDate != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    _buildInfoRow(
                      context,
                      'Unlocks',
                      note.unlockDate!.formattedDateTime,
                      Icons.lock_clock_outlined,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: AppSpacing.iconSm,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          '$label:',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  BadgeVariant _getBadgeVariant(NoteType type) {
    return switch (type) {
      NoteType.standard => BadgeVariant.primary,
      NoteType.vault => BadgeVariant.warning,
      NoteType.mystery => BadgeVariant.secondary,
      NoteType.timeCapsule => BadgeVariant.info,
      NoteType.challenge => BadgeVariant.error,
    };
  }

  void _handleEdit(BuildContext context) {
    // Navigate to edit page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<NotesBloc>(),
          child: BlocProvider.value(
            value: context.read<PointsBloc>(),
            child: NoteEditorPage(note: note),
          ),
        ),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'pin':
        context.read<NotesBloc>().add(PinNoteToggle(note.id));
        break;
      case 'favorite':
        context.read<NotesBloc>().add(FavoriteNoteToggle(note.id));
        break;
      case 'delete':
        _showDeleteConfirmation(context);
        break;
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Are you sure you want to delete this note?'),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Cost: ${PointCosts.deleteNote} points',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.warning,
                fontWeight: FontWeight.bold,
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
            text: 'Delete',
            backgroundColor: AppColors.error,
            onPressed: () {
              context.read<NotesBloc>().add(NoteDelete(note.id));
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop(); // Go back to notes list
            },
          ),
        ],
      ),
    );
  }
}
