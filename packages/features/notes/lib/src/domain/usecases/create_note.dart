import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class CreateNote {
  final NotesRepository repository;

  CreateNote(this.repository);

  Future<Either<Failure, Note>> call(CreateNoteParams params) async {
    // Validate
    if (params.title.trim().isEmpty) {
      return const Left(ValidationFailure('Title cannot be empty'));
    }

    return await repository.createNote(
      title: params.title,
      content: params.content,
      noteType: params.noteType,
      categoryId: params.categoryId,
      color: params.color,
    );
  }
}

class CreateNoteParams {
  final String title;
  final String content;
  final NoteType noteType;
  final int? categoryId;
  final String? color;

  const CreateNoteParams({
    required this.title,
    required this.content,
    this.noteType = NoteType.standard,
    this.categoryId,
    this.color,
  });
}
