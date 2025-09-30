import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/note.dart';
import '../repositories/notes_repository.dart';

class UpdateNote {
  final NotesRepository repository;

  UpdateNote(this.repository);

  Future<Either<Failure, Note>> call(UpdateNoteParams params) async {
    // Validate
    if (params.title != null && params.title!.trim().isEmpty) {
      return const Left(ValidationFailure('Title cannot be empty'));
    }

    return await repository.updateNote(
      id: params.id,
      title: params.title,
      content: params.content,
      categoryId: params.categoryId,
      color: params.color,
    );
  }
}

class UpdateNoteParams {
  final int id;
  final String? title;
  final String? content;
  final int? categoryId;
  final String? color;

  const UpdateNoteParams({
    required this.id,
    this.title,
    this.content,
    this.categoryId,
    this.color,
  });
}
