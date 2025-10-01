import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../repositories/points_repository.dart';

class GetPointBalance {
  final PointsRepository repository;

  GetPointBalance(this.repository);

  Future<Either<Failure, int>> call() async {
    return await repository.getPointBalance();
  }
}
