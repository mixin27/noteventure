import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/note.dart';
import '../entities/category.dart';

abstract class NotesRepository {
  /// Get all notes
  Future<Either<Failure, List<Note>>> getAllNotes();

  /// Get notes by category
  Future<Either<Failure, List<Note>>> getNotesByCategory(String categoryId);

  /// Get note by ID
  Future<Either<Failure, Note>> getNoteById(String id);

  /// Get pinned notes
  Future<Either<Failure, List<Note>>> getPinnedNotes();

  /// Get favorite notes
  Future<Either<Failure, List<Note>>> getFavoriteNotes();

  /// Search notes
  Future<Either<Failure, List<Note>>> searchNotes(String query);

  /// Create note
  Future<Either<Failure, Note>> createNote({
    required String title,
    required String content,
    NoteType noteType = NoteType.standard,
    String? categoryId,
    String? color,
  });

  /// Update note
  Future<Either<Failure, Note>> updateNote({
    required String id,
    String? title,
    String? content,
    String? categoryId,
    String? color,
  });

  /// Delete note (soft delete)
  Future<Either<Failure, void>> deleteNote(String id);

  /// Toggle pin status
  Future<Either<Failure, Note>> togglePin(String id);

  /// Toggle favorite status
  Future<Either<Failure, Note>> toggleFavorite(String id);

  /// Get all categories
  Future<Either<Failure, List<Category>>> getAllCategories();

  /// Create category
  Future<Either<Failure, Category>> createCategory({
    required String name,
    required String color,
    String? icon,
  });

  /// Update category
  Future<Either<Failure, Category>> updateCategory({
    required String id,
    String? name,
    String? color,
    String? icon,
  });

  /// Delete category
  Future<Either<Failure, void>> deleteCategory(String id);

  /// Watch notes (stream)
  Stream<Either<Failure, List<Note>>> watchAllNotes();

  /// Watch note by ID (stream)
  Stream<Either<Failure, Note>> watchNoteById(String id);
}
