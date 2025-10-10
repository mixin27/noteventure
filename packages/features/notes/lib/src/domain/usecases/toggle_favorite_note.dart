import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class ToggleFavoriteNote {
  final NotesRepository repository;

  ToggleFavoriteNote(this.repository);

  Future<Either<Failure, Note>> call(String noteId) async {
    return await repository.toggleFavorite(noteId);
  }
}
