import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_local_datasource.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesLocalDataSource localDataSource;

  NotesRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final notes = await localDataSource.getAllNotes();
      return Right(notes.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getNotesByCategory(
    String categoryId,
  ) async {
    try {
      final notes = await localDataSource.getNotesByCategory(categoryId);
      return Right(notes.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Note>> getNoteById(String id) async {
    try {
      final note = await localDataSource.getNoteById(id);
      return Right(note.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getPinnedNotes() async {
    try {
      final notes = await localDataSource.getPinnedNotes();
      return Right(notes.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> getFavoriteNotes() async {
    try {
      final notes = await localDataSource.getFavoriteNotes();
      return Right(notes.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Note>>> searchNotes(String query) async {
    try {
      final notes = await localDataSource.searchNotes(query);
      return Right(notes.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Note>> createNote({
    required String title,
    required String content,
    NoteType noteType = NoteType.standard,
    String? categoryId,
    String? color,
    bool isPinned = false,
    bool isFavorite = false,
  }) async {
    try {
      final note = await localDataSource.createNote(
        title: title,
        content: content,
        noteType: noteType,
        categoryId: categoryId,
        color: color,
        isPinned: isPinned,
        isFavorite: isFavorite,
      );
      return Right(note.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Note>> createNoteWithId({
    required String id,
    required String title,
    required String content,
    required NoteType noteType,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? categoryId,
    String? color,
    bool isPinned = false,
    bool isFavorite = false,
  }) async {
    try {
      final note = await localDataSource.createNote(
        id: id,
        title: title,
        content: content,
        noteType: noteType,
        categoryId: categoryId,
        color: color,
        isPinned: isPinned,
        isFavorite: isFavorite,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
      return Right(note.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Note>> updateNote({
    required String id,
    String? title,
    String? content,
    String? categoryId,
    String? color,
    bool? isPinned,
    bool? isFavorite,
  }) async {
    try {
      final note = await localDataSource.updateNote(
        id: id,
        title: title,
        content: content,
        categoryId: categoryId,
        color: color,
        isPinned: isPinned,
        isFavorite: isFavorite,
      );
      return Right(note.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String id) async {
    try {
      await localDataSource.deleteNote(id);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Note>> togglePin(String id) async {
    try {
      final note = await localDataSource.togglePin(id);
      return Right(note.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Note>> toggleFavorite(String id) async {
    try {
      final note = await localDataSource.toggleFavorite(id);
      return Right(note.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final categories = await localDataSource.getAllCategories();
      return Right(categories.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> createCategory({
    required String name,
    required String color,
    String? icon,
  }) async {
    try {
      final category = await localDataSource.createCategory(
        name: name,
        color: color,
        icon: icon,
      );
      return Right(category.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Category>> updateCategory({
    required String id,
    String? name,
    String? color,
    String? icon,
  }) async {
    try {
      final category = await localDataSource.updateCategory(
        id: id,
        name: name,
        color: color,
        icon: icon,
      );
      return Right(category.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(String id) async {
    try {
      await localDataSource.deleteCategory(id);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<Note>>> watchAllNotes() {
    try {
      return localDataSource.watchAllNotes().map(
        (notes) => Right(notes.map((model) => model.toEntity()).toList()),
      );
    } catch (e) {
      return Stream.value(Left(UnknownFailure(e.toString())));
    }
  }

  @override
  Stream<Either<Failure, Note>> watchNoteById(String id) {
    try {
      return localDataSource
          .watchNoteById(id)
          .map((note) => Right(note.toEntity()));
    } catch (e) {
      return Stream.value(Left(UnknownFailure(e.toString())));
    }
  }
}
