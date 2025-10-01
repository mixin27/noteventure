import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../repositories/points_repository.dart';

class EarnPoints {
  final PointsRepository repository;

  EarnPoints(this.repository);

  Future<Either<Failure, int>> call(EarnPointsParams params) async {
    return await repository.earnPoints(
      amount: params.amount,
      reason: params.reason,
      description: params.description,
      relatedChallengeId: params.relatedChallengeId,
    );
  }
}

class EarnPointsParams {
  final int amount;
  final String reason;
  final String? description;
  final int? relatedChallengeId;

  const EarnPointsParams({
    required this.amount,
    required this.reason,
    this.description,
    this.relatedChallengeId,
  });
}
