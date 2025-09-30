import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/note.dart';
import '../entities/category.dart';

abstract class NotesRepository {
  /// Get all notes
  Future<Either<Failure, List<Note>>> getAllNotes();

  /// Get notes by category
  Future<Either<Failure, List<Note>>> getNotesByCategory(int categoryId);

  /// Get note by ID
  Future<Either<Failure, Note>> getNoteById(int id);

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
    int? categoryId,
    String? color,
  });

  /// Update note
  Future<Either<Failure, Note>> updateNote({
    required int id,
    String? title,
    String? content,
    int? categoryId,
    String? color,
  });

  /// Delete note (soft delete)
  Future<Either<Failure, void>> deleteNote(int id);

  /// Toggle pin status
  Future<Either<Failure, Note>> togglePin(int id);

  /// Toggle favorite status
  Future<Either<Failure, Note>> toggleFavorite(int id);

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
    required int id,
    String? name,
    String? color,
    String? icon,
  });

  /// Delete category
  Future<Either<Failure, void>> deleteCategory(int id);

  /// Watch notes (stream)
  Stream<Either<Failure, List<Note>>> watchAllNotes();

  /// Watch note by ID (stream)
  Stream<Either<Failure, Note>> watchNoteById(int id);
}
