import 'package:drift/drift.dart';

import '../app_database.dart';

@DataClassName('Theme')
class Themes extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get themeKey => text().unique()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get unlockCost => integer()();
  BoolColumn get isUnlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  // Theme colors
  TextColumn get primaryColor => text()();
  TextColumn get secondaryColor => text()();
  TextColumn get backgroundColor => text()();
  TextColumn get surfaceColor => text()();
  TextColumn get themeStyle => text()(); // "retro", "vaporwave", etc.

  @override
  Set<Column> get primaryKey => {id};
}
