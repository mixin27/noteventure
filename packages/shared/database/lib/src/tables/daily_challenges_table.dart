import 'package:drift/drift.dart';

import '../app_database.dart';

@DataClassName('DailyChallenge')
class DailyChallenges extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  DateTimeColumn get date => dateTime()();
  TextColumn get challengeType => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get targetCount => integer()(); // e.g., "Solve 5 math problems"
  IntColumn get currentProgress => integer().withDefault(const Constant(0))();
  IntColumn get pointReward => integer()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
