import 'package:database/database.dart' as db;

import '../../domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.id,
    required super.title,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
    required super.editCount,
    required super.noteType,
    required super.isLocked,
    super.unlockDate,
    super.categoryId,
    required super.sortOrder,
    super.color,
    required super.isPinned,
    required super.isFavorite,
    super.requiredChallengeLevel,
    required super.isDeleted,
    super.deletedAt,
  });

  /// Convert from Drift Note to NoteModel
  factory NoteModel.fromDrift(db.Note driftNote) {
    return NoteModel(
      id: driftNote.id,
      title: driftNote.title,
      content: driftNote.content,
      createdAt: driftNote.createdAt,
      updatedAt: driftNote.updatedAt,
      editCount: driftNote.editCount,
      noteType: NoteType.fromString(driftNote.noteType),
      isLocked: driftNote.isLocked,
      unlockDate: driftNote.unlockDate,
      categoryId: driftNote.categoryId,
      sortOrder: driftNote.sortOrder,
      color: driftNote.color,
      isPinned: driftNote.isPinned,
      isFavorite: driftNote.isFavorite,
      requiredChallengeLevel: driftNote.requiredChallengeLevel,
      isDeleted: driftNote.isDeleted,
      deletedAt: driftNote.deletedAt,
    );
  }

  /// Convert NoteModel to Note entity
  Note toEntity() {
    return Note(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      updatedAt: updatedAt,
      editCount: editCount,
      noteType: noteType,
      isLocked: isLocked,
      unlockDate: unlockDate,
      categoryId: categoryId,
      sortOrder: sortOrder,
      color: color,
      isPinned: isPinned,
      isFavorite: isFavorite,
      requiredChallengeLevel: requiredChallengeLevel,
      isDeleted: isDeleted,
      deletedAt: deletedAt,
    );
  }
}
