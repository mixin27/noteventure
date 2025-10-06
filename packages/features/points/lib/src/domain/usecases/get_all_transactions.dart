import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/point_transaction.dart';
import '../repositories/points_repository.dart';

class GetAllTransactions {
  final PointsRepository repository;
  GetAllTransactions(this.repository);

  Future<Either<Failure, List<PointTransaction>>> call() {
    return repository.getAllTransactions();
  }
}
