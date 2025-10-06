import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/achievement.dart';

abstract class AchievementsRepository {
  Future<Either<Failure, List<Achievement>>> getAllAchievements();
  Future<Either<Failure, List<Achievement>>> getUnlockedAchievements();
  Future<Either<Failure, List<Achievement>>> getLockedAchievements();
  Future<Either<Failure, Achievement>> getAchievementByKey(String key);
  Future<Either<Failure, Unit>> updateProgress(String key, int progress);
  Future<Either<Failure, Achievement?>> unlockAchievement(String key);
  Future<Either<Failure, Unit>> initializeAchievements();
  Stream<List<Achievement>> watchAchievements();
}
