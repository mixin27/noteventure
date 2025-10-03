import 'package:database/database.dart';

import '../models/achievement_model.dart';

abstract class AchievementsLocalDataSource {
  Future<List<AchievementModel>> getAllAchievements();
  Future<List<AchievementModel>> getUnlockedAchievements();
  Future<List<AchievementModel>> getLockedAchievements();
  Future<AchievementModel?> getAchievementByKey(String key);
  Future<void> updateProgress(String key, int progress);
  Future<void> unlockAchievement(String key);
  Future<void> initializeAchievements();
  Stream<List<AchievementModel>> watchAchievements();
}

class AchievementsLocalDataSourceImpl implements AchievementsLocalDataSource {
  final AchievementsDao achievementsDao;

  AchievementsLocalDataSourceImpl(this.achievementsDao);

  @override
  Future<List<AchievementModel>> getAllAchievements() async {
    final achievements = await achievementsDao.getAllAchievements();
    return achievements.map((a) => AchievementModel.fromDrift(a)).toList();
  }

  @override
  Future<List<AchievementModel>> getUnlockedAchievements() async {
    final achievements = await achievementsDao.getUnlockedAchievements();
    return achievements.map((a) => AchievementModel.fromDrift(a)).toList();
  }

  @override
  Future<List<AchievementModel>> getLockedAchievements() async {
    final achievements = await achievementsDao.getLockedAchievements();
    return achievements.map((a) => AchievementModel.fromDrift(a)).toList();
  }

  @override
  Future<AchievementModel?> getAchievementByKey(String key) async {
    final achievement = await achievementsDao.getAchievementByKey(key);
    return achievement != null ? AchievementModel.fromDrift(achievement) : null;
  }

  @override
  Future<void> updateProgress(String key, int progress) async {
    await achievementsDao.updateProgress(key, progress);
  }

  @override
  Future<void> unlockAchievement(String key) async {
    await achievementsDao.unlockAchievement(key);
  }

  @override
  Future<void> initializeAchievements() async {
    // final count = await achievementsDao.getAchievementsCount();
    // if (count == 0) {
    //   // Insert default achievements
    //   await achievementsDao.insertDefaultAchievements();
    // }
    throw UnimplementedError();
  }

  @override
  Stream<List<AchievementModel>> watchAchievements() {
    return achievementsDao.watchAllAchievements().map(
      (list) => list.map((a) => AchievementModel.fromDrift(a)).toList(),
    );
  }
}
