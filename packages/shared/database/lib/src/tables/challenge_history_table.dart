import 'package:drift/drift.dart';

import '../app_database.dart';
import 'notes_table.dart';

@DataClassName('ChallengeHistoryEntry')
class ChallengeHistory extends Table {
  // IntColumn get id => integer().autoIncrement()();
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get challengeType =>
      text()(); // "math", "trivia", "word_game", etc.
  TextColumn get difficulty => text()(); // "easy", "medium", "hard"
  IntColumn get difficultyLevel => integer()(); // Numeric difficulty (1-10)

  TextColumn get question => text()();
  TextColumn get correctAnswer => text()();
  TextColumn get userAnswer => text().nullable()();

  BoolColumn get wasCorrect => boolean()();
  IntColumn get pointsEarned => integer()();
  IntColumn get xpEarned => integer()();

  IntColumn get timeSpentSeconds => integer().nullable()();
  IntColumn get timeLimitSeconds => integer().nullable()();

  BoolColumn get wasDoubleOrNothing =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get wasPartOfStreak =>
      boolean().withDefault(const Constant(false))();

  DateTimeColumn get completedAt =>
      dateTime().withDefault(currentDateAndTime)();

  // Context
  TextColumn get triggerReason =>
      text()(); // "note_creation", "note_edit", etc.
  IntColumn get relatedNoteId => integer().nullable().references(
    Notes,
    #id,
    onDelete: KeyAction.setNull,
  )();

  @override
  Set<Column> get primaryKey => {id};
}
