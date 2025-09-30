import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/user_progress_table.dart';

part 'user_progress_dao.g.dart';

@DriftAccessor(tables: [UserProgressTable])
class UserProgressDao extends DatabaseAccessor<AppDatabase>
    with _$UserProgressDaoMixin {
  UserProgressDao(super.db);

  /// Get user progress (there should only be one row)
  Future<UserProgress?> getUserProgress() {
    return select(userProgressTable).getSingleOrNull();
  }

  /// Watch user progress for real-time updates
  Stream<UserProgress?> watchUserProgress() {
    return select(userProgressTable).watchSingleOrNull();
  }

  /// Update points
  Future<int> updatePoints(int newBalance) async {
    final progress = await getUserProgress();
    if (progress == null) return 0;

    return (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        totalPoints: Value(newBalance),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Add XP and check for level up
  Future<Map<String, dynamic>> addXp(int xpAmount) async {
    final progress = await getUserProgress();
    if (progress == null) {
      return {'leveledUp': false, 'newLevel': 1};
    }

    final newXp = progress.currentXp + xpAmount;
    var newLevel = progress.level;
    var xpForNextLevel = progress.xpToNextLevel;
    var remainingXp = newXp;
    var leveledUp = false;

    // Check for level up(s)
    while (remainingXp >= xpForNextLevel) {
      remainingXp -= xpForNextLevel;
      newLevel++;
      leveledUp = true;
      // Calculate XP needed for next level (increasing curve)
      xpForNextLevel = (xpForNextLevel * 1.5).round();
    }

    await (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        level: Value(newLevel),
        currentXp: Value(remainingXp),
        xpToNextLevel: Value(xpForNextLevel),
        updatedAt: Value(DateTime.now()),
      ),
    );

    return {
      'leveledUp': leveledUp,
      'newLevel': newLevel,
      'oldLevel': progress.level,
    };
  }

  /// Update streak
  Future<int> updateStreak(bool success) async {
    final progress = await getUserProgress();
    if (progress == null) return 0;

    final now = DateTime.now();
    int newStreak = progress.currentStreak;
    int newLongestStreak = progress.longestStreak;

    if (success) {
      // Check if this is a continuation of streak (same day or next day)
      if (progress.lastChallengeDate != null) {
        final daysDifference = now
            .difference(progress.lastChallengeDate!)
            .inDays;

        if (daysDifference == 0) {
          // Same day, just increment the challenge count but keep streak
          newStreak++;
        } else if (daysDifference == 1) {
          // Next day, increment streak
          newStreak++;
        } else {
          // Streak broken, start over
          newStreak = 1;
        }
      } else {
        // First challenge
        newStreak = 1;
      }

      // Update longest streak if current is higher
      if (newStreak > newLongestStreak) {
        newLongestStreak = newStreak;
      }
    } else {
      // Failed, reset streak
      newStreak = 0;
    }

    return (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        currentStreak: Value(newStreak),
        longestStreak: Value(newLongestStreak),
        lastChallengeDate: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  /// Increment challenges solved
  Future<int> incrementChallengesSolved() async {
    final progress = await getUserProgress();
    if (progress == null) return 0;
    return (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        totalChallengesSolved: Value(progress.totalChallengesSolved + 1),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Increment challenges failed
  Future<int> incrementChallengesFailed() async {
    final progress = await getUserProgress();
    if (progress == null) return 0;
    return (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        totalChallengesFailed: Value(progress.totalChallengesFailed + 1),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Increment notes created
  Future<int> incrementNotesCreated() async {
    final progress = await getUserProgress();
    if (progress == null) return 0;
    return (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        totalNotesCreated: Value(progress.totalNotesCreated + 1),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Increment notes deleted
  Future<int> incrementNotesDeleted() async {
    final progress = await getUserProgress();
    if (progress == null) return 0;
    return (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        totalNotesDeleted: Value(progress.totalNotesDeleted + 1),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update lifetime points earned
  Future<int> updateLifetimePointsEarned(int amount) async {
    final progress = await getUserProgress();
    if (progress == null) return 0;
    return (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        lifetimePointsEarned: Value(progress.lifetimePointsEarned + amount),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update lifetime points spent
  Future<int> updateLifetimePointsSpent(int amount) async {
    final progress = await getUserProgress();
    if (progress == null) return 0;
    return (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        lifetimePointsSpent: Value(progress.lifetimePointsSpent + amount),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update settings
  Future<int> updateSettings({
    bool? chaosEnabled,
    int? challengeTimeLimit,
    String? personalityTone,
    bool? soundEnabled,
    bool? notificationsEnabled,
  }) async {
    final progress = await getUserProgress();
    if (progress == null) return 0;
    return (update(
      userProgressTable,
    )..where((tbl) => tbl.id.equals(progress.id))).write(
      UserProgressTableCompanion(
        chaosEnabled: chaosEnabled != null
            ? Value(chaosEnabled)
            : const Value.absent(),
        challengeTimeLimit: challengeTimeLimit != null
            ? Value(challengeTimeLimit)
            : const Value.absent(),
        personalityTone: personalityTone != null
            ? Value(personalityTone)
            : const Value.absent(),
        soundEnabled: soundEnabled != null
            ? Value(soundEnabled)
            : const Value.absent(),
        notificationsEnabled: notificationsEnabled != null
            ? Value(notificationsEnabled)
            : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}
