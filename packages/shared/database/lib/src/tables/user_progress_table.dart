import 'package:drift/drift.dart';

@DataClassName('UserProgress')
class UserProgressTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get totalPoints => integer().withDefault(const Constant(100))();
  IntColumn get lifetimePointsEarned =>
      integer().withDefault(const Constant(0))();
  IntColumn get lifetimePointsSpent =>
      integer().withDefault(const Constant(0))();

  // Level & XP
  IntColumn get level => integer().withDefault(const Constant(1))();
  IntColumn get currentXp => integer().withDefault(const Constant(0))();
  IntColumn get xpToNextLevel => integer().withDefault(const Constant(100))();

  // Streaks
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastChallengeDate => dateTime().nullable()();

  // Stats
  IntColumn get totalChallengesSolved =>
      integer().withDefault(const Constant(0))();
  IntColumn get totalChallengesFailed =>
      integer().withDefault(const Constant(0))();
  IntColumn get totalNotesCreated => integer().withDefault(const Constant(0))();
  IntColumn get totalNotesDeleted => integer().withDefault(const Constant(0))();

  // Settings/Preferences
  BoolColumn get chaosEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get challengeTimeLimit =>
      integer().withDefault(const Constant(30))();
  TextColumn get personalityTone =>
      text().withDefault(const Constant('random'))();
  BoolColumn get soundEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get notificationsEnabled =>
      boolean().withDefault(const Constant(true))();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'user_progress';
}
