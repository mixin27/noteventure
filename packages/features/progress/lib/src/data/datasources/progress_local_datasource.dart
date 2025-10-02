import 'package:database/database.dart';
import 'package:core/core.dart';

import '../models/user_progress_model.dart';

abstract class ProgressLocalDataSource {
  Future<UserProgressModel> getUserProgress();
  Future<Map<String, dynamic>> addXp(int amount);
  Future<UserProgressModel> updateStreak(bool success);
  Future<void> incrementChallengesSolved();
  Future<void> incrementChallengesFailed();
  Future<void> incrementNotesCreated();
  Future<void> incrementNotesDeleted();
  Stream<UserProgressModel> watchProgress();
}

class ProgressLocalDataSourceImpl implements ProgressLocalDataSource {
  final UserProgressDao userProgressDao;

  ProgressLocalDataSourceImpl(this.userProgressDao);

  @override
  Future<UserProgressModel> getUserProgress() async {
    final progress = await userProgressDao.getUserProgress();
    if (progress == null) {
      throw const DatabaseException('User progress not found');
    }
    return UserProgressModel.fromDrift(progress);
  }

  @override
  Future<Map<String, dynamic>> addXp(int amount) async {
    final result = await userProgressDao.addXp(amount);

    // Emit events via EventBus
    AppEventBus().emit(XpGainedEvent(amount: amount, source: 'challenge'));

    if (result['leveledUp'] == true) {
      AppEventBus().emit(
        LevelUpEvent(
          oldLevel: result['oldLevel'],
          newLevel: result['newLevel'],
        ),
      );
    }

    return result;
  }

  @override
  Future<UserProgressModel> updateStreak(bool success) async {
    await userProgressDao.updateStreak(success);

    final progress = await userProgressDao.getUserProgress();
    if (progress == null) {
      throw const DatabaseException('User progress not found');
    }

    // Emit streak event if updated
    if (success && progress.currentStreak > 0) {
      AppEventBus().emit(
        StreakUpdatedEvent(
          currentStreak: progress.currentStreak,
          isNewRecord: progress.currentStreak == progress.longestStreak,
        ),
      );
    }

    return UserProgressModel.fromDrift(progress);
  }

  @override
  Future<void> incrementChallengesSolved() async {
    await userProgressDao.incrementChallengesSolved();
  }

  @override
  Future<void> incrementChallengesFailed() async {
    await userProgressDao.incrementChallengesFailed();
  }

  @override
  Future<void> incrementNotesCreated() async {
    await userProgressDao.incrementNotesCreated();
  }

  @override
  Future<void> incrementNotesDeleted() async {
    await userProgressDao.incrementNotesDeleted();
  }

  @override
  Stream<UserProgressModel> watchProgress() {
    return userProgressDao.watchUserProgress().map((progress) {
      if (progress == null) {
        throw const DatabaseException('User progress not found');
      }
      return UserProgressModel.fromDrift(progress);
    });
  }
}
