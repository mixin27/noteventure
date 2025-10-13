import 'package:drift/drift.dart';

import '../app_database.dart';

@DataClassName('SyncLog')
class SyncLogs extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())();

  // Sync type
  TextColumn get syncType => text()(); // 'manual' or 'background'

  // Result
  BoolColumn get success => boolean()();
  TextColumn get errorMessage => text().nullable()();

  // Details
  IntColumn get notesSynced => integer().withDefault(const Constant(0))();
  IntColumn get transactionsSynced =>
      integer().withDefault(const Constant(0))();
  BoolColumn get progressSynced =>
      boolean().withDefault(const Constant(false))();
  IntColumn get conflictsFound => integer().withDefault(const Constant(0))();

  // Duration
  IntColumn get durationMs => integer().nullable()();

  // Timestamp
  DateTimeColumn get syncedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
