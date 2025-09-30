import 'package:equatable/equatable.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/note.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object?> get props => [];
}

/// Initial state
final class NotesInitial extends NotesState {
  const NotesInitial();
}

/// Loading state
final class NotesLoading extends NotesState {
  const NotesLoading();
}

/// Notes loaded successfully
final class NotesLoaded extends NotesState {
  final List<Note> notes;
  final List<Category> categories;

  const NotesLoaded({required this.notes, this.categories = const []});

  @override
  List<Object?> get props => [notes, categories];
}

/// Search results loaded
final class NotesSearchResults extends NotesState {
  final List<Note> results;
  final String query;

  const NotesSearchResults({required this.results, required this.query});

  @override
  List<Object?> get props => [results, query];
}

/// Note action requires challenge (insufficient points)
final class NoteActionRequiresChallenge extends NotesState {
  final String action; // "create", "edit", "delete", "preview"
  final int pointCost;
  final int currentPoints;
  final int? noteId;

  const NoteActionRequiresChallenge({
    required this.action,
    required this.pointCost,
    required this.currentPoints,
    this.noteId,
  });

  @override
  List<Object?> get props => [action, pointCost, currentPoints, noteId];
}

/// Note created successfully
final class NoteCreated extends NotesState {
  final Note note;
  final String message;

  const NoteCreated({
    required this.note,
    this.message = 'Note created successfully!',
  });

  @override
  List<Object?> get props => [note, message];
}

/// Note updated successfully
final class NoteUpdated extends NotesState {
  final Note note;
  final String message;

  const NoteUpdated({
    required this.note,
    this.message = 'Note updated successfully!',
  });

  @override
  List<Object?> get props => [note, message];
}

/// Note deleted successfully
final class NoteDeleted extends NotesState {
  final String message;

  const NoteDeleted({this.message = 'Note deleted successfully!'});

  @override
  List<Object?> get props => [message];
}

/// Note toggled (pin/favorite)
final class NoteToggled extends NotesState {
  final Note note;
  final String message;

  const NoteToggled({required this.note, required this.message});

  @override
  List<Object?> get props => [note, message];
}

/// Error state
final class NotesError extends NotesState {
  final String message;

  const NotesError(this.message);

  @override
  List<Object?> get props => [message];
}
