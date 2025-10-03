import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/achievements_repository.dart';

class UnlockAchievement {
  final AchievementsRepository repository;

  UnlockAchievement(this.repository);

  Future<Either<Failure, Unit>> call(String key) {
    return repository.unlockAchievement(key);
  }
}
