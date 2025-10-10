import 'package:drift/drift.dart';

import '../app_database.dart';

@DataClassName('Category')
class Categories extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get color => text()();
  TextColumn get icon => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
