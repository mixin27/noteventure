import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class TogglePinNote {
  final NotesRepository repository;

  TogglePinNote(this.repository);

  Future<Either<Failure, Note>> call(String noteId) async {
    return await repository.togglePin(noteId);
  }
}
