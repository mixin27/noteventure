import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../entities/user_progress.dart';
import '../repositories/progress_repository.dart';

class UpdateStreak {
  final ProgressRepository repository;

  UpdateStreak(this.repository);

  Future<Either<Failure, UserProgress>> call(bool success) async {
    return await repository.updateStreak(success);
  }
}
