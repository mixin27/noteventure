import 'package:equatable/equatable.dart';

import '../../domain/entities/note.dart';

sealed class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

/// Load all notes
final class NotesLoad extends NotesEvent {
  const NotesLoad();
}

/// Load notes by category
final class NotesByCategoryLoad extends NotesEvent {
  final int categoryId;

  const NotesByCategoryLoad(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

/// Load pinned notes
final class PinnedNotesLoad extends NotesEvent {
  const PinnedNotesLoad();
}

/// Load favorite notes
final class FavoriteNotesLoad extends NotesEvent {
  const FavoriteNotesLoad();
}

/// Search notes
final class NotesSearch extends NotesEvent {
  final String query;

  const NotesSearch(this.query);

  @override
  List<Object?> get props => [query];
}

/// Request note creation (check points)
final class NoteCreationRequest extends NotesEvent {
  final NoteType noteType;

  const NoteCreationRequest(this.noteType);

  @override
  List<Object?> get props => [noteType];
}

/// Create note (after points are spent)
final class NoteCreate extends NotesEvent {
  final String title;
  final String content;
  final NoteType noteType;
  final int? categoryId;
  final String? color;

  const NoteCreate({
    required this.title,
    required this.content,
    this.noteType = NoteType.standard,
    this.categoryId,
    this.color,
  });

  @override
  List<Object?> get props => [title, content, noteType, categoryId, color];
}

/// Request note edit (check points)
final class NoteEditRequest extends NotesEvent {
  final int noteId;

  const NoteEditRequest(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

/// Update note (after points are spent)
final class NoteUpdate extends NotesEvent {
  final int id;
  final String? title;
  final String? content;
  final int? categoryId;
  final String? color;

  const NoteUpdate({
    required this.id,
    this.title,
    this.content,
    this.categoryId,
    this.color,
  });

  @override
  List<Object?> get props => [id, title, content, categoryId, color];
}

/// Request note preview (check points)
final class NotePreviewRequest extends NotesEvent {
  final int noteId;

  const NotePreviewRequest(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

/// Request note deletion (check points)
final class NoteDeletionRequest extends NotesEvent {
  final int noteId;

  const NoteDeletionRequest(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

/// Delete note (after points are spent)
final class NoteDelete extends NotesEvent {
  final int noteId;

  const NoteDelete(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

/// Toggle pin status
final class PinNoteToggle extends NotesEvent {
  final int noteId;

  const PinNoteToggle(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

/// Toggle favorite status
final class FavoriteNoteToggle extends NotesEvent {
  final int noteId;

  const FavoriteNoteToggle(this.noteId);

  @override
  List<Object?> get props => [noteId];
}

/// Refresh notes (for pull-to-refresh)
final class NotesRefresh extends NotesEvent {
  const NotesRefresh();
}
