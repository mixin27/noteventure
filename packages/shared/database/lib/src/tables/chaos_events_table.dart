import 'package:drift/drift.dart';

import '../app_database.dart';

@DataClassName('ChaosEvent')
class ChaosEvents extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get eventKey => text()();
  TextColumn get eventType => text()(); // "positive", "negative", "neutral"
  TextColumn get title => text()();
  TextColumn get message => text()();
  DateTimeColumn get triggeredAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get wasResolved => boolean().withDefault(const Constant(false))();
  IntColumn get pointsAwarded => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
