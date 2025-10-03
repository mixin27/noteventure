import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/achievements_repository.dart';

class UpdateAchievementProgress {
  final AchievementsRepository repository;

  UpdateAchievementProgress(this.repository);

  Future<Either<Failure, Unit>> call(String key, int progress) {
    return repository.updateProgress(key, progress);
  }
}
