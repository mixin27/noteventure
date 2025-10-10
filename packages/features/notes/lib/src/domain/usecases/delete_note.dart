import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../repositories/notes_repository.dart';

class DeleteNote {
  final NotesRepository repository;

  DeleteNote(this.repository);

  Future<Either<Failure, void>> call(String noteId) async {
    return await repository.deleteNote(noteId);
  }
}
