import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/achievement.dart';
import '../../domain/repositories/achievements_repository.dart';
import '../datasources/achievements_local_datasource.dart';

class AchievementsRepositoryImpl implements AchievementsRepository {
  final AchievementsLocalDataSource localDataSource;

  AchievementsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Achievement>>> getAllAchievements() async {
    try {
      final achievements = await localDataSource.getAllAchievements();
      return Right(achievements.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Achievement>>> getUnlockedAchievements() async {
    try {
      final achievements = await localDataSource.getUnlockedAchievements();
      return Right(achievements.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Achievement>>> getLockedAchievements() async {
    try {
      final achievements = await localDataSource.getLockedAchievements();
      return Right(achievements.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Achievement>> getAchievementByKey(String key) async {
    try {
      final achievement = await localDataSource.getAchievementByKey(key);
      if (achievement == null) {
        return Left(CacheFailure('Achievement not found: $key'));
      }
      return Right(achievement.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProgress(String key, int progress) async {
    try {
      await localDataSource.updateProgress(key, progress);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Achievement?>> unlockAchievement(String key) async {
    try {
      await localDataSource.unlockAchievement(key);
      final result = await localDataSource.getAchievementByKey(key);

      return Right(result?.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> initializeAchievements() async {
    try {
      await localDataSource.initializeAchievements();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Stream<List<Achievement>> watchAchievements() {
    return localDataSource.watchAchievements().map(
      (list) => list.map((m) => m.toEntity()).toList(),
    );
  }
}
