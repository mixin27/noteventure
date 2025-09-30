import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int editCount;
  final NoteType noteType;
  final bool isLocked;
  final DateTime? unlockDate;
  final int? categoryId;
  final int sortOrder;
  final String? color;
  final bool isPinned;
  final bool isFavorite;
  final int? requiredChallengeLevel;
  final bool isDeleted;
  final DateTime? deletedAt;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.editCount,
    required this.noteType,
    required this.isLocked,
    this.unlockDate,
    this.categoryId,
    required this.sortOrder,
    this.color,
    required this.isPinned,
    required this.isFavorite,
    this.requiredChallengeLevel,
    required this.isDeleted,
    this.deletedAt,
  });

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? editCount,
    NoteType? noteType,
    bool? isLocked,
    DateTime? unlockDate,
    int? categoryId,
    int? sortOrder,
    String? color,
    bool? isPinned,
    bool? isFavorite,
    int? requiredChallengeLevel,
    bool? isDeleted,
    DateTime? deletedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      editCount: editCount ?? this.editCount,
      noteType: noteType ?? this.noteType,
      isLocked: isLocked ?? this.isLocked,
      unlockDate: unlockDate ?? this.unlockDate,
      categoryId: categoryId ?? this.categoryId,
      sortOrder: sortOrder ?? this.sortOrder,
      color: color ?? this.color,
      isPinned: isPinned ?? this.isPinned,
      isFavorite: isFavorite ?? this.isFavorite,
      requiredChallengeLevel:
          requiredChallengeLevel ?? this.requiredChallengeLevel,
      isDeleted: isDeleted ?? this.isDeleted,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    createdAt,
    updatedAt,
    editCount,
    noteType,
    isLocked,
    unlockDate,
    categoryId,
    sortOrder,
    color,
    isPinned,
    isFavorite,
    requiredChallengeLevel,
    isDeleted,
    deletedAt,
  ];
}

enum NoteType {
  standard,
  vault,
  mystery,
  timeCapsule,
  challenge;

  String get displayName => switch (this) {
    NoteType.standard => 'Standard',
    NoteType.vault => 'Vault',
    NoteType.mystery => 'Mystery',
    NoteType.timeCapsule => 'Time Capsule',
    NoteType.challenge => 'Challenge',
  };

  static NoteType fromString(String value) {
    return NoteType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => NoteType.standard,
    );
  }
}
