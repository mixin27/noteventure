import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import 'app_database.steps.dart';
import 'daos/achievements_dao.dart';
import 'daos/app_settings_dao.dart';
import 'daos/chaos_events_dao.dart';
import 'daos/notes_dao.dart';
import 'daos/point_transactions_dao.dart';
import 'daos/sync_logs_dao.dart';
import 'daos/themes_dao.dart';
import 'daos/user_progress_dao.dart';
import 'tables/achievements_table.dart';
import 'tables/active_effects_table.dart';
import 'tables/app_settings_table.dart';
import 'tables/categories_table.dart';
import 'tables/challenge_history_table.dart';
import 'tables/challenge_questions_table.dart';
import 'tables/chaos_events_table.dart';
import 'tables/daily_challenges_table.dart';
import 'tables/notes_table.dart';
import 'tables/point_transactions_table.dart';
import 'tables/sync_logs_table.dart';
import 'tables/themes_table.dart';
import 'tables/user_progress_table.dart';

part 'app_database.g.dart';

final uuid = Uuid();

@singleton
@DriftDatabase(
  tables: [
    Notes,
    Categories,
    PointTransactions,
    UserProgressTable,
    Achievements,
    ActiveEffects,
    ChaosEvents,
    Themes,
    ChallengeHistory,
    DailyChallenges,
    ChallengeQuestions,
    AppSettings,
    SyncLogs,
  ],
  daos: [
    NotesDao,
    PointTransactionsDao,
    UserProgressDao,
    AchievementsDao,
    ChaosEventsDao,
    ThemesDao,
    AppSettingsDao,
    SyncLogsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  // Constructor for testing
  // ignore: use_super_parameters
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _insertInitialData();
      },
      onUpgrade: stepByStep(
        from1To2: (m, schema) async {
          await m.create(syncLogs);
        },
      ),
    );
  }

  /// Insert initial data after database creation
  Future<void> _insertInitialData() async {
    // Insert default user progress
    await into(userProgressTable).insert(
      UserProgressTableCompanion.insert(
        totalPoints: const Value(100), // Starting points
        level: const Value(1),
        currentXp: const Value(0),
        xpToNextLevel: const Value(100),
      ),
    );
  }
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'noteventure', native: const DriftNativeOptions());
  // return LazyDatabase(() async {
  //   final dbFolder = await getApplicationDocumentsDirectory();
  //   final file = File(p.join(dbFolder.path, 'noteventure.db'));
  //   return NativeDatabase(file);
  // });
}
