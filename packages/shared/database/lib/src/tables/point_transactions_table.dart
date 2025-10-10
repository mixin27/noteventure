import 'package:drift/drift.dart';

import '../app_database.dart';
import 'challenge_history_table.dart';
import 'chaos_events_table.dart';
import 'notes_table.dart';

@DataClassName('PointTransaction')
class PointTransactions extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  IntColumn get amount => integer()(); // Can be negative
  TextColumn get reason => text()(); // "challenge_solved", "note_created", etc.
  TextColumn get description => text().nullable()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();

  // Relations
  TextColumn get relatedNoteId =>
      text().nullable().references(Notes, #id, onDelete: KeyAction.setNull)();
  TextColumn get relatedChallengeId => text().nullable().references(
    ChallengeHistory,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get relatedEventId => text().nullable().references(
    ChaosEvents,
    #id,
    onDelete: KeyAction.setNull,
  )();

  // Running balance snapshot (for quick balance calculation)
  IntColumn get balanceAfter => integer()();

  TextColumn get serverUuid => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
