import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/achievement.dart';
import '../repositories/achievements_repository.dart';

class UnlockAchievement {
  final AchievementsRepository repository;

  UnlockAchievement(this.repository);

  Future<Either<Failure, Achievement?>> call(String key) {
    return repository.unlockAchievement(key);
  }
}
