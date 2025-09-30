import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class SearchNotes {
  final NotesRepository repository;

  SearchNotes(this.repository);

  Future<Either<Failure, List<Note>>> call(String query) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }

    return await repository.searchNotes(query);
  }
}
