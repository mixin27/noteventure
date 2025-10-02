import 'package:injectable/injectable.dart';

import '../app_database.dart';
import '../daos/app_settings_dao.dart';
import '../daos/notes_dao.dart';
import '../daos/user_progress_dao.dart';
import '../daos/point_transactions_dao.dart';
import '../daos/achievements_dao.dart';
import '../daos/themes_dao.dart';

@module
abstract class DatabaseModule {
  @singleton
  AppDatabase get database => AppDatabase();

  @singleton
  NotesDao notesDao(AppDatabase db) => NotesDao(db);

  @singleton
  UserProgressDao userProgressDao(AppDatabase db) => UserProgressDao(db);

  @singleton
  PointTransactionsDao pointTransactionsDao(AppDatabase db) =>
      PointTransactionsDao(db);

  @singleton
  AchievementsDao achievementsDao(AppDatabase db) => AchievementsDao(db);

  @singleton
  ThemesDao themesDao(AppDatabase db) => ThemesDao(db);

  @singleton
  AppSettingsDao appSettingsDao(AppDatabase db) => AppSettingsDao(db);
}
