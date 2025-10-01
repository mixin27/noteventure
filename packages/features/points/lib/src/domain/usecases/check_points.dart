import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../repositories/points_repository.dart';

class CheckPoints {
  final PointsRepository repository;

  CheckPoints(this.repository);

  Future<Either<Failure, bool>> call(int required) async {
    return await repository.hasEnoughPoints(required);
  }
}
