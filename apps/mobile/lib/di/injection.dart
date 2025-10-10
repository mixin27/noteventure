import 'package:achievements/achievements.dart';
import 'package:auth/auth.dart';
import 'package:challenges/challenges.dart';
import 'package:chaos/chaos.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:database/database.dart';
import 'package:notes/notes.dart';
import 'package:points/points.dart';
import 'package:progress/progress.dart';
import 'package:settings/settings.dart';
import 'package:syncing/syncing.dart';
import 'package:themes/themes.dart';

import '../routes/app_router.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Initialize database
  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);

  // Register DAOs
  getIt.registerSingleton<NotesDao>(NotesDao(database));
  getIt.registerSingleton<UserProgressDao>(UserProgressDao(database));
  getIt.registerSingleton<PointTransactionsDao>(PointTransactionsDao(database));
  getIt.registerSingleton<AchievementsDao>(AchievementsDao(database));
  getIt.registerSingleton<ChaosEventsDao>(ChaosEventsDao(database));
  getIt.registerSingleton<ThemesDao>(ThemesDao(database));
  getIt.registerSingleton<AppSettingsDao>(AppSettingsDao(database));

  // Core
  initCoreInjection();

  // Initialize features
  initAuthFeature();
  initNotesFeature();
  initPointsFeature();
  initChallengesFeature();
  initProgressFeature();
  initAchievementsFeature();
  initChaosDependencies();
  initThemesFeature();
  initSettingsDependencies();
  initSyncingFeature();

  // Router
  getIt.registerLazySingleton(() => AppRouter(getIt()));
}
