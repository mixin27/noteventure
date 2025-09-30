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

  /// Get achievement unlock percentage
  Future<double> getUnlockPercentage() async {
    final all = await getAllAchievements();
    if (all.isEmpty) return 0;

    final unlocked = all.where((a) => a.isUnlocked).length;
    return (unlocked / all.length) * 100;
  }
}
