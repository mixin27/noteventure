import 'package:drift/drift.dart';

import 'challenge_history_table.dart';
import 'chaos_events_table.dart';
import 'notes_table.dart';

@DataClassName('PointTransaction')
class PointTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()(); // Can be negative
  TextColumn get reason => text()(); // "challenge_solved", "note_created", etc.
  TextColumn get description => text().nullable()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();

  // Relations
  IntColumn get relatedNoteId => integer().nullable().references(
    Notes,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get relatedChallengeId => integer().nullable().references(
    ChallengeHistory,
    #id,
    onDelete: KeyAction.setNull,
  )();
  IntColumn get relatedEventId => integer().nullable().references(
    ChaosEvents,
    #id,
    onDelete: KeyAction.setNull,
  )();

  // Running balance snapshot (for quick balance calculation)
  IntColumn get balanceAfter => integer()();
}
