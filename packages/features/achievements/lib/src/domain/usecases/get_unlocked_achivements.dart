import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/achievement.dart';
import '../repositories/achievements_repository.dart';

class GetUnlockedAchievements {
  final AchievementsRepository repository;

  GetUnlockedAchievements(this.repository);

  Future<Either<Failure, List<Achievement>>> call() {
    return repository.getUnlockedAchievements();
  }
}
