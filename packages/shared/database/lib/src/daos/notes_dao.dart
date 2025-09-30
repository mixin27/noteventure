import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/notes_table.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(super.db);

  /// Get all notes (excluding deleted)
  Future<List<Note>> getAllNotes() {
    return (select(notes)
          ..where((tbl) => tbl.isDeleted.equals(false))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.isPinned, mode: OrderingMode.desc),
            (tbl) => OrderingTerm(
              expression: tbl.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Get notes by category
  Future<List<Note>> getNotesByCategory(int categoryId) {
    return (select(notes)
          ..where(
            (tbl) =>
                tbl.categoryId.equals(categoryId) & tbl.isDeleted.equals(false),
          )
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Get note by ID
  Future<Note?> getNoteById(int id) {
    return (select(notes)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Get pinned notes
  Future<List<Note>> getPinnedNotes() {
    return (select(notes)
          ..where(
            (tbl) => tbl.isPinned.equals(true) & tbl.isDeleted.equals(false),
          )
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Get favorite notes
  Future<List<Note>> getFavoriteNotes() {
    return (select(notes)
          ..where(
            (tbl) => tbl.isFavorite.equals(true) & tbl.isDeleted.equals(false),
          )
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Create note
  Future<int> createNote(NotesCompanion note) {
    return into(notes).insert(note);
  }

  /// Update note
  Future<bool> updateNote(NotesCompanion note) {
    return update(notes).replace(note);
  }

  /// Delete note (soft delete)
  Future<int> softDeleteNote(int id) {
    return (update(notes)..where((tbl) => tbl.id.equals(id))).write(
      NotesCompanion(
        isDeleted: const Value(true),
        deletedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Permanently delete note
  Future<int> permanentlyDeleteNote(int id) {
    return (delete(notes)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Toggle pin status
  Future<int> togglePin(int id, bool isPinned) {
    return (update(notes)..where((tbl) => tbl.id.equals(id))).write(
      NotesCompanion(isPinned: Value(isPinned)),
    );
  }

  /// Toggle favorite status
  Future<int> toggleFavorite(int id, bool isFavorite) {
    return (update(notes)..where((tbl) => tbl.id.equals(id))).write(
      NotesCompanion(isFavorite: Value(isFavorite)),
    );
  }

  /// Search notes
  Future<List<Note>> searchNotes(String query) {
    final lowerQuery = query.toLowerCase();
    return (select(notes)
          ..where(
            (tbl) =>
                (tbl.title.lower().like('%$lowerQuery%') |
                    tbl.content.lower().like('%$lowerQuery%')) &
                tbl.isDeleted.equals(false),
          )
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Watch all notes (for real-time updates)
  Stream<List<Note>> watchAllNotes() {
    return (select(notes)
          ..where((tbl) => tbl.isDeleted.equals(false))
          ..orderBy([
            (tbl) =>
                OrderingTerm(expression: tbl.isPinned, mode: OrderingMode.desc),
            (tbl) => OrderingTerm(
              expression: tbl.updatedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .watch();
  }

  /// Watch note by ID
  Stream<Note?> watchNoteById(int id) {
    return (select(
      notes,
    )..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }
}
