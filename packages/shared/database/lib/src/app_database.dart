import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:injectable/injectable.dart';

import 'daos/achievements_dao.dart';
import 'daos/app_settings_dao.dart';
import 'daos/chaos_events_dao.dart';
import 'daos/notes_dao.dart';
import 'daos/point_transactions_dao.dart';
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
import 'tables/themes_table.dart';
import 'tables/user_progress_table.dart';

part 'app_database.g.dart';

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
  ],
  daos: [
    NotesDao,
    PointTransactionsDao,
    UserProgressDao,
    AchievementsDao,
    ChaosEventsDao,
    ThemesDao,
    AppSettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  // Constructor for testing
  // ignore: use_super_parameters
  AppDatabase.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _insertInitialData();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle migrations here in the future
      },
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

    // Insert default achievements
    // await _insertDefaultAchievements();

    // Insert default themes
    // await _insertDefaultThemes();
  }

  // /// Insert default achievements
  // Future<void> _insertDefaultAchievements() async {
  //   final achievementsData = [
  //     AchievementsCompanion.insert(
  //       achievementKey: 'first_note',
  //       name: 'First Steps',
  //       description: 'Create your first note',
  //       iconName: 'note',
  //       targetValue: 1,
  //       pointReward: const Value(10),
  //       rarity: const Value('common'),
  //     ),
  //     AchievementsCompanion.insert(
  //       achievementKey: 'note_hoarder',
  //       name: 'Note Hoarder',
  //       description: 'Create 50 notes',
  //       iconName: 'notes_stack',
  //       targetValue: 50,
  //       pointReward: const Value(100),
  //       rarity: const Value('rare'),
  //     ),
  //     AchievementsCompanion.insert(
  //       achievementKey: 'speed_demon',
  //       name: 'Speed Demon',
  //       description: 'Solve 10 challenges in under 5 seconds each',
  //       iconName: 'flash',
  //       targetValue: 10,
  //       pointReward: const Value(150),
  //       rarity: const Value('epic'),
  //     ),
  //     AchievementsCompanion.insert(
  //       achievementKey: 'risk_taker',
  //       name: 'Risk Taker',
  //       description: 'Win 5 double-or-nothing challenges',
  //       iconName: 'dice',
  //       targetValue: 5,
  //       pointReward: const Value(200),
  //       rarity: const Value('epic'),
  //     ),
  //     AchievementsCompanion.insert(
  //       achievementKey: 'deletion_king',
  //       name: 'Deletion King',
  //       description: 'Delete 20 notes',
  //       iconName: 'trash',
  //       targetValue: 20,
  //       pointReward: const Value(75),
  //       rarity: const Value('common'),
  //     ),
  //     AchievementsCompanion.insert(
  //       achievementKey: 'streak_master',
  //       name: 'Streak Master',
  //       description: 'Achieve a 10 challenge streak',
  //       iconName: 'fire',
  //       targetValue: 10,
  //       pointReward: const Value(250),
  //       rarity: const Value('legendary'),
  //     ),
  //     AchievementsCompanion.insert(
  //       achievementKey: 'level_10',
  //       name: 'Leveling Up',
  //       description: 'Reach level 10',
  //       iconName: 'star',
  //       targetValue: 10,
  //       pointReward: const Value(300),
  //       rarity: const Value('epic'),
  //     ),
  //     AchievementsCompanion.insert(
  //       achievementKey: 'math_genius',
  //       name: 'Math Genius',
  //       description: 'Solve 100 math challenges',
  //       iconName: 'calculator',
  //       targetValue: 100,
  //       pointReward: const Value(200),
  //       rarity: const Value('rare'),
  //     ),
  //     AchievementsCompanion.insert(
  //       achievementKey: 'trivia_master',
  //       name: 'Trivia Master',
  //       description: 'Solve 100 trivia challenges',
  //       iconName: 'lightbulb',
  //       targetValue: 100,
  //       pointReward: const Value(200),
  //       rarity: const Value('rare'),
  //     ),
  //     AchievementsCompanion.insert(
  //       achievementKey: 'point_millionaire',
  //       name: 'Point Millionaire',
  //       description: 'Earn 10,000 total lifetime points',
  //       iconName: 'diamond',
  //       targetValue: 10000,
  //       pointReward: const Value(500),
  //       rarity: const Value('legendary'),
  //     ),
  //   ];

  //   for (final achievement in achievementsData) {
  //     await into(achievements).insert(achievement);
  //   }
  // }

  // /// Insert default themes
  // Future<void> _insertDefaultThemes() async {
  //   final themesList = [
  //     ThemesCompanion.insert(
  //       themeKey: 'default',
  //       name: 'Default',
  //       description: 'The classic Noteventure theme',
  //       unlockCost: 0,
  //       isUnlocked: const Value(true),
  //       isActive: const Value(true),
  //       primaryColor: '#6366F1',
  //       secondaryColor: '#8B5CF6',
  //       backgroundColor: '#FFFFFF',
  //       surfaceColor: '#F3F4F6',
  //       themeStyle: 'modern',
  //     ),
  //     ThemesCompanion.insert(
  //       themeKey: 'retro_terminal',
  //       name: 'Retro Terminal',
  //       description: 'Green text on black, Matrix vibes',
  //       unlockCost: 100,
  //       primaryColor: '#00FF00',
  //       secondaryColor: '#00CC00',
  //       backgroundColor: '#000000',
  //       surfaceColor: '#0A0A0A',
  //       themeStyle: 'retro',
  //     ),
  //     ThemesCompanion.insert(
  //       themeKey: 'vaporwave',
  //       name: 'Vaporwave',
  //       description: 'Pink and purple aesthetic dreams',
  //       unlockCost: 150,
  //       primaryColor: '#FF71CE',
  //       secondaryColor: '#01CDFE',
  //       backgroundColor: '#2E2157',
  //       surfaceColor: '#3A2A5E',
  //       themeStyle: 'vaporwave',
  //     ),
  //     ThemesCompanion.insert(
  //       themeKey: 'brutalist',
  //       name: 'Brutalist',
  //       description: 'Stark, gray, minimalist',
  //       unlockCost: 75,
  //       primaryColor: '#212121',
  //       secondaryColor: '#757575',
  //       backgroundColor: '#FAFAFA',
  //       surfaceColor: '#E0E0E0',
  //       themeStyle: 'brutalist',
  //     ),
  //     ThemesCompanion.insert(
  //       themeKey: 'comic_book',
  //       name: 'Comic Book',
  //       description: 'POW! BAM! Speech bubbles!',
  //       unlockCost: 200,
  //       primaryColor: '#FF0000',
  //       secondaryColor: '#FFD700',
  //       backgroundColor: '#FFFFFF',
  //       surfaceColor: '#FFEB3B',
  //       themeStyle: 'comic',
  //     ),
  //     ThemesCompanion.insert(
  //       themeKey: 'handwritten',
  //       name: 'Handwritten',
  //       description: 'Notebook paper vibes',
  //       unlockCost: 125,
  //       primaryColor: '#1E88E5',
  //       secondaryColor: '#43A047',
  //       backgroundColor: '#FFF8DC',
  //       surfaceColor: '#FFFACD',
  //       themeStyle: 'handwritten',
  //     ),
  //     ThemesCompanion.insert(
  //       themeKey: 'neon_cyberpunk',
  //       name: 'Neon Cyberpunk',
  //       description: 'Glowing edges and dark backgrounds',
  //       unlockCost: 250,
  //       primaryColor: '#00F0FF',
  //       secondaryColor: '#FF00FF',
  //       backgroundColor: '#0A0A0A',
  //       surfaceColor: '#1A1A1A',
  //       themeStyle: 'cyberpunk',
  //     ),
  //   ];

  //   for (final theme in themesList) {
  //     await into(themes).insert(theme);
  //   }
  // }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'noteventure.db'));
    return NativeDatabase(file);
  });
}
