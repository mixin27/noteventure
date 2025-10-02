import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../entities/user_progress.dart';
import '../repositories/progress_repository.dart';

class GetUserProgress {
  final ProgressRepository repository;

  GetUserProgress(this.repository);

  Future<Either<Failure, UserProgress>> call() async {
    return await repository.getUserProgress();
  }
}
