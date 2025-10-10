import 'package:drift/drift.dart';

import 'chaos_events_table.dart';

import '../app_database.dart';

@DataClassName('ActiveEffect')
class ActiveEffects extends Table {
  // IntColumn get id => integer().autoIncrement()();
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get effectType => text()(); // "discount_50", "double_points", etc.
  RealColumn get multiplier => real().withDefault(const Constant(1.0))();
  DateTimeColumn get startedAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get expiresAt => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get description => text()();
  IntColumn get relatedEventId => integer().nullable().references(
    ChaosEvents,
    #id,
    onDelete: KeyAction.setNull,
  )();

  @override
  Set<Column> get primaryKey => {id};
}
