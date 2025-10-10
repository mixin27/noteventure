import 'dart:developer';

import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:drift/drift.dart';

import '../models/note_model.dart';
import '../models/category_model.dart';
import '../../domain/entities/note.dart';

abstract class NotesLocalDataSource {
  Future<List<NoteModel>> getAllNotes();
  Future<List<NoteModel>> getNotesByCategory(String categoryId);
  Future<NoteModel> getNoteById(String id);
  Future<List<NoteModel>> getPinnedNotes();
  Future<List<NoteModel>> getFavoriteNotes();
  Future<List<NoteModel>> searchNotes(String query);
  Future<NoteModel> createNote({
    required String title,
    required String content,
    NoteType noteType = NoteType.standard,
    String? categoryId,
    String? color,
  });
  Future<NoteModel> updateNote({
    required String id,
    String? title,
    String? content,
    String? categoryId,
    String? color,
  });
  Future<void> deleteNote(String id);
  Future<NoteModel> togglePin(String id);
  Future<NoteModel> toggleFavorite(String id);
  Future<List<CategoryModel>> getAllCategories();
  Future<CategoryModel> createCategory({
    required String name,
    required String color,
    String? icon,
  });
  Future<CategoryModel> updateCategory({
    required String id,
    String? name,
    String? color,
    String? icon,
  });
  Future<void> deleteCategory(String id);
  Stream<List<NoteModel>> watchAllNotes();
  Stream<NoteModel> watchNoteById(String id);
}

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  final NotesDao notesDao;

  NotesLocalDataSourceImpl(this.notesDao);

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final notes = await notesDao.getAllNotes();
    return notes.map((note) => NoteModel.fromDrift(note)).toList();
  }

  @override
  Future<List<NoteModel>> getNotesByCategory(String categoryId) async {
    final notes = await notesDao.getNotesByCategory(categoryId);
    return notes.map((note) => NoteModel.fromDrift(note)).toList();
  }

  @override
  Future<NoteModel> getNoteById(String id) async {
    final note = await notesDao.getNoteById(id);
    if (note == null) {
      throw const NotFoundException('Note not found');
    }
    return NoteModel.fromDrift(note);
  }

  @override
  Future<List<NoteModel>> getPinnedNotes() async {
    final notes = await notesDao.getPinnedNotes();
    return notes.map((note) => NoteModel.fromDrift(note)).toList();
  }

  @override
  Future<List<NoteModel>> getFavoriteNotes() async {
    final notes = await notesDao.getFavoriteNotes();
    return notes.map((note) => NoteModel.fromDrift(note)).toList();
  }

  @override
  Future<List<NoteModel>> searchNotes(String query) async {
    final notes = await notesDao.searchNotes(query);
    return notes.map((note) => NoteModel.fromDrift(note)).toList();
  }

  @override
  Future<NoteModel> createNote({
    required String title,
    required String content,
    NoteType noteType = NoteType.standard,
    String? categoryId,
    String? color,
  }) async {
    final noteId = uuid.v4();
    final companion = NotesCompanion.insert(
      id: Value(noteId),
      title: title,
      content: content,
      noteType: Value(noteType.name),
      categoryId: Value(categoryId),
      color: Value(color),
    );

    await notesDao.createNote(companion);

    final note = await notesDao.getNoteById(noteId);
    if (note == null) {
      throw const DatabaseException('Failed to create note');
    }

    return NoteModel.fromDrift(note);
  }

  @override
  Future<NoteModel> updateNote({
    required String id,
    String? title,
    String? content,
    String? categoryId,
    String? color,
  }) async {
    final companion = NotesCompanion(
      id: Value(id),
      title: title != null ? Value(title) : const Value.absent(),
      content: content != null ? Value(content) : const Value.absent(),
      categoryId: categoryId != null ? Value(categoryId) : const Value.absent(),
      color: color != null ? Value(color) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
      editCount:
          const Value.absent(), // Will be incremented by trigger or manually
    );

    final success = await notesDao.updateNote(companion);
    if (!success) {
      throw const DatabaseException('Failed to update note');
    }

    final note = await notesDao.getNoteById(id);
    if (note == null) {
      throw const NotFoundException('Note not found after update');
    }

    return NoteModel.fromDrift(note);
  }

  @override
  Future<void> deleteNote(String id) async {
    await notesDao.softDeleteNote(id);
  }

  @override
  Future<NoteModel> togglePin(String id) async {
    final note = await notesDao.getNoteById(id);
    if (note == null) {
      throw const NotFoundException('Note not found');
    }

    await notesDao.togglePin(id, !note.isPinned);

    final updatedNote = await notesDao.getNoteById(id);
    if (updatedNote == null) {
      throw const DatabaseException('Failed to toggle pin');
    }

    return NoteModel.fromDrift(updatedNote);
  }

  @override
  Future<NoteModel> toggleFavorite(String id) async {
    final note = await notesDao.getNoteById(id);
    if (note == null) {
      throw const NotFoundException('Note not found');
    }

    await notesDao.toggleFavorite(id, !note.isFavorite);

    final updatedNote = await notesDao.getNoteById(id);
    if (updatedNote == null) {
      throw const DatabaseException('Failed to toggle favorite');
    }

    return NoteModel.fromDrift(updatedNote);
  }

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    // todo(mixin27): Implement when CategoriesDao is created
    return [];
  }

  @override
  Future<CategoryModel> createCategory({
    required String name,
    required String color,
    String? icon,
  }) async {
    // todo(mixin27): Implement when CategoriesDao is created
    throw UnimplementedError();
  }

  @override
  Future<CategoryModel> updateCategory({
    required String id,
    String? name,
    String? color,
    String? icon,
  }) async {
    // todo(mixin27): Implement when CategoriesDao is created
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCategory(String id) async {
    // todo(mixin27): Implement when CategoriesDao is created
    throw UnimplementedError();
  }

  @override
  Stream<List<NoteModel>> watchAllNotes() {
    return notesDao.watchAllNotes().map(
      (notes) => notes.map((note) => NoteModel.fromDrift(note)).toList(),
    );
  }

  @override
  Stream<NoteModel> watchNoteById(String id) {
    return notesDao.watchNoteById(id).map((note) {
      if (note == null) {
        throw const NotFoundException('Note not found');
      }
      return NoteModel.fromDrift(note);
    });
  }
}
