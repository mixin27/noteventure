import 'package:drift/drift.dart';

import 'categories_table.dart';

@DataClassName('Note')
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get editCount => integer().withDefault(const Constant(0))();

  // Note type: standard, vault, mystery, timeCapsule, challenge
  TextColumn get noteType => text().withDefault(const Constant('standard'))();

  // Lock/unlock functionality
  BoolColumn get isLocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockDate => dateTime().nullable()();

  // Organization
  IntColumn get categoryId => integer().nullable().references(
    Categories,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  // Special note metadata
  TextColumn get color => text().nullable()();
  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  // Challenge note specific
  IntColumn get requiredChallengeLevel => integer().nullable()();

  // Soft delete
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
