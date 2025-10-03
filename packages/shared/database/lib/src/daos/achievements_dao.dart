import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/achievements_table.dart';

part 'achievements_dao.g.dart';

@DriftAccessor(tables: [Achievements])
class AchievementsDao extends DatabaseAccessor<AppDatabase>
    with _$AchievementsDaoMixin {
  AchievementsDao(super.db);

  /// Get all achievements
  Future<List<Achievement>> getAllAchievements() {
    return (select(achievements)..orderBy([
          (tbl) =>
              OrderingTerm(expression: tbl.isUnlocked, mode: OrderingMode.desc),
          (tbl) => OrderingTerm(expression: tbl.rarity),
        ]))
        .get();
  }

  /// Get unlocked achievements
  Future<List<Achievement>> getUnlockedAchievements() {
    return (select(achievements)
          ..where((tbl) => tbl.isUnlocked.equals(true))
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.unlockedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Get locked achievements
  Future<List<Achievement>> getLockedAchievements() {
    return (select(
      achievements,
    )..where((tbl) => tbl.isUnlocked.equals(false))).get();
  }

  /// Get achievement by key
  Future<Achievement?> getAchievementByKey(String key) {
    return (select(
      achievements,
    )..where((tbl) => tbl.achievementKey.equals(key))).getSingleOrNull();
  }

  /// Update achievement progress
  Future<int> updateProgress(String achievementKey, int progress) async {
    final achievement = await getAchievementByKey(achievementKey);
    if (achievement == null) return 0;

    final isNowUnlocked =
        progress >= achievement.targetValue && !achievement.isUnlocked;

    return (update(
      achievements,
    )..where((tbl) => tbl.achievementKey.equals(achievementKey))).write(
      AchievementsCompanion(
        currentProgress: Value(progress),
        isUnlocked: Value(isNowUnlocked || achievement.isUnlocked),
        unlockedAt: isNowUnlocked
            ? Value(DateTime.now())
            : const Value.absent(),
      ),
    );
  }

  /// Unlock achievement
  Future<int> unlockAchievement(String achievementKey) {
    return (update(
      achievements,
    )..where((tbl) => tbl.achievementKey.equals(achievementKey))).write(
      AchievementsCompanion(
        isUnlocked: const Value(true),
        unlockedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Get achievements by rarity
  Future<List<Achievement>> getAchievementsByRarity(String rarity) {
    return (select(
      achievements,
    )..where((tbl) => tbl.rarity.equals(rarity))).get();
  }

  /// Watch all achievements
  Stream<List<Achievement>> watchAllAchievements() {
    return (select(achievements)..orderBy([
          (tbl) =>
              OrderingTerm(expression: tbl.isUnlocked, mode: OrderingMode.desc),
          (tbl) => OrderingTerm(expression: tbl.rarity),
        ]))
        .watch();
  }

  Stream<List<Achievement>> watchUnlockedAchievements() {
    final query = select(achievements)
      ..where((tbl) => tbl.isUnlocked.equals(true));
    return query.watch();
  }

  Future<int> getAchievementsCount() async {
    final countQuery = selectOnly(achievements)
      ..addColumns([achievements.id.count()]);
    final result = await countQuery.getSingle();
    return result.read(achievements.id.count()) ?? 0;
  }

  Future<int> getUnlockedCount() async {
    final countQuery = selectOnly(achievements)
      ..addColumns([achievements.id.count()])
      ..where(achievements.isUnlocked.equals(true));
    final result = await countQuery.getSingle();
    return result.read(achievements.id.count()) ?? 0;
  }

  /// Get achievement unlock percentage
  Future<double> getUnlockPercentage() async {
    final all = await getAllAchievements();
    if (all.isEmpty) return 0;

    final unlocked = all.where((a) => a.isUnlocked).length;
    return (unlocked / all.length) * 100;
  }

  Future<void> insertDefaultAchievements() async {
    await batch((batch) {
      batch.insertAll(
        achievements,
        _getDefaultAchievements(),
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  List<AchievementsCompanion> _getDefaultAchievements() {
    return [
      // Challenge Achievements
      AchievementsCompanion.insert(
        achievementKey: 'first_challenge',
        name: 'First Steps',
        description: 'Complete your first challenge',
        iconName: 'first_challenge',
        targetValue: 1,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(50),
        rarity: Value('common'),
      ),
      AchievementsCompanion.insert(
        achievementKey: 'challenge_master',
        name: 'Challenge Master',
        description: 'Complete 100 challenges',
        iconName: 'challenge_master',
        targetValue: 100,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(500),
        rarity: Value('epic'),
      ),
      AchievementsCompanion.insert(
        achievementKey: 'speed_demon',
        name: 'Speed Demon',
        description: 'Solve 10 challenges in under 5 seconds each',
        iconName: 'speed_demon',
        targetValue: 10,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(300),
        rarity: Value('rare'),
      ),
      AchievementsCompanion.insert(
        achievementKey: 'risk_taker',
        name: 'Risk Taker',
        description: 'Win 5 double-or-nothing challenges',
        iconName: 'risk_taker',
        targetValue: 5,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(200),
        rarity: Value('rare'),
      ),

      // Note Achievements
      AchievementsCompanion.insert(
        achievementKey: 'first_note',
        name: 'Note Taker',
        description: 'Create your first note',
        iconName: 'first_note',
        targetValue: 1,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(25),
        rarity: Value('common'),
      ),
      AchievementsCompanion.insert(
        achievementKey: 'note_hoarder',
        name: 'Note Hoarder',
        description: 'Create 50 notes',
        iconName: 'note_hoarder',
        targetValue: 50,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(250),
        rarity: Value('rare'),
      ),
      AchievementsCompanion.insert(
        achievementKey: 'deletion_king',
        name: 'Deletion King',
        description: 'Delete 20 notes',
        iconName: 'deletion_king',
        targetValue: 20,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(150),
        rarity: Value('common'),
      ),

      // Streak Achievements
      AchievementsCompanion.insert(
        achievementKey: 'streak_starter',
        name: 'Streak Starter',
        description: 'Maintain a 3-day streak',
        iconName: 'streak_master',
        targetValue: 3,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(100),
        rarity: Value('common'),
      ),
      AchievementsCompanion.insert(
        achievementKey: 'streak_master',
        name: 'Streak Master',
        description: 'Maintain a 30-day streak',
        iconName: 'streak_master',
        targetValue: 30,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(1000),
        rarity: Value('legendary'),
      ),

      // Level Achievements
      AchievementsCompanion.insert(
        achievementKey: 'level_10',
        name: 'Rising Star',
        description: 'Reach level 10',
        iconName: 'challenge_master',
        targetValue: 10,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(200),
        rarity: Value('common'),
      ),
      AchievementsCompanion.insert(
        achievementKey: 'level_50',
        name: 'Legendary',
        description: 'Reach level 50',
        iconName: 'challenge_master',
        targetValue: 50,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(2000),
        rarity: Value('legendary'),
      ),

      // Points Achievements
      AchievementsCompanion.insert(
        achievementKey: 'point_collector',
        name: 'Point Collector',
        description: 'Earn 1,000 total points',
        iconName: 'first_challenge',
        targetValue: 1000,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(100),
        rarity: Value('common'),
      ),
      AchievementsCompanion.insert(
        achievementKey: 'point_master',
        name: 'Point Master',
        description: 'Earn 10,000 total points',
        iconName: 'challenge_master',
        targetValue: 10000,
        currentProgress: Value(0),
        isUnlocked: Value(false),
        pointReward: Value(1000),
        rarity: Value('epic'),
      ),
    ];
  }

  Future<void> resetAllAchievements() async {
    await delete(achievements).go();
    await insertDefaultAchievements();
  }
}
