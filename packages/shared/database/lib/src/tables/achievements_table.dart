import 'package:drift/drift.dart';

import '../app_database.dart';

@DataClassName('Achievement')
class Achievements extends Table {
  // IntColumn get id => integer().autoIncrement()();
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get achievementKey => text().unique()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get iconName => text()();
  IntColumn get targetValue => integer()();
  IntColumn get currentProgress => integer().withDefault(const Constant(0))();
  BoolColumn get isUnlocked => boolean().withDefault(const Constant(false))();
  DateTimeColumn get unlockedAt => dateTime().nullable()();
  IntColumn get pointReward => integer().withDefault(const Constant(0))();
  TextColumn get rarity => text().withDefault(
    const Constant('common'),
  )(); // common, rare, epic, legendary

  @override
  Set<Column> get primaryKey => {id};
}
