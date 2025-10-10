import 'package:drift/drift.dart';

import '../app_database.dart';

@DataClassName('ChallengeQuestion')
class ChallengeQuestions extends Table {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get challengeType => text()();
  TextColumn get difficulty => text()();
  TextColumn get question => text()();
  TextColumn get correctAnswer => text()();
  TextColumn get wrongAnswers =>
      text().nullable()(); // JSON array for multiple choice
  TextColumn get explanation => text().nullable()();
  TextColumn get category =>
      text().nullable()(); // For trivia: "history", "science", etc.
  IntColumn get timesUsed => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastUsed => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
