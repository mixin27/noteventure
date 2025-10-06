import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/point_transaction.dart';
import '../repositories/points_repository.dart';

class GetRecentTransactions {
  final PointsRepository repository;
  GetRecentTransactions(this.repository);

  Future<Either<Failure, List<PointTransaction>>> call({int limit = 10}) {
    return repository.getRecentTransactions(limit);
  }
}
