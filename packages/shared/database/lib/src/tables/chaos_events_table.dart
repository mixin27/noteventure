import 'package:drift/drift.dart';

@DataClassName('ChaosEvent')
class ChaosEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get eventKey => text()();
  TextColumn get eventType => text()(); // "positive", "negative", "neutral"
  TextColumn get title => text()();
  TextColumn get message => text()();
  DateTimeColumn get triggeredAt =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get wasResolved => boolean().withDefault(const Constant(false))();
  IntColumn get pointsAwarded => integer().withDefault(const Constant(0))();
}
