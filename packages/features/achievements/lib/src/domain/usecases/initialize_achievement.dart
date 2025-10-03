import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/achievements_repository.dart';

class InitializeAchievements {
  final AchievementsRepository repository;

  InitializeAchievements(this.repository);

  Future<Either<Failure, Unit>> call() {
    return repository.initializeAchievements();
  }
}
