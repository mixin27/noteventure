import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/points_repository.dart';

class WatchPointsBalance {
  final PointsRepository repository;
  WatchPointsBalance(this.repository);

  Stream<Either<Failure, int>> call() {
    return repository.watchPointBalance();
  }
}
