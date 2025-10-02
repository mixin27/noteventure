import 'package:database/database.dart' as db;
import 'package:core/core.dart';

import '../../domain/entities/user_progress.dart';

class UserProgressModel extends UserProgress {
  const UserProgressModel({
    required super.level,
    required super.currentXp,
    required super.xpToNextLevel,
    required super.totalXp,
    required super.currentStreak,
    required super.longestStreak,
    super.lastChallengeDate,
    required super.totalChallengesSolved,
    required super.totalChallengesFailed,
    required super.totalNotesCreated,
    required super.totalNotesDeleted,
  });

  factory UserProgressModel.fromDrift(db.UserProgress driftProgress) {
    // Calculate total XP from level and current XP
    final totalXp =
        XpCalculator.totalXpForLevel(driftProgress.level) +
        driftProgress.currentXp;

    return UserProgressModel(
      level: driftProgress.level,
      currentXp: driftProgress.currentXp,
      xpToNextLevel: driftProgress.xpToNextLevel,
      totalXp: totalXp,
      currentStreak: driftProgress.currentStreak,
      longestStreak: driftProgress.longestStreak,
      lastChallengeDate: driftProgress.lastChallengeDate,
      totalChallengesSolved: driftProgress.totalChallengesSolved,
      totalChallengesFailed: driftProgress.totalChallengesFailed,
      totalNotesCreated: driftProgress.totalNotesCreated,
      totalNotesDeleted: driftProgress.totalNotesDeleted,
    );
  }

  UserProgress toEntity() {
    return UserProgress(
      level: level,
      currentXp: currentXp,
      xpToNextLevel: xpToNextLevel,
      totalXp: totalXp,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastChallengeDate: lastChallengeDate,
      totalChallengesSolved: totalChallengesSolved,
      totalChallengesFailed: totalChallengesFailed,
      totalNotesCreated: totalNotesCreated,
      totalNotesDeleted: totalNotesDeleted,
    );
  }
}
