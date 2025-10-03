import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/achievement.dart';
import '../repositories/achievements_repository.dart';

class GetAllAchievements {
  final AchievementsRepository repository;

  GetAllAchievements(this.repository);

  Future<Either<Failure, List<Achievement>>> call() {
    return repository.getAllAchievements();
  }
}
