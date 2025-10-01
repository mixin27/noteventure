import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../repositories/points_repository.dart';

class SpendPoints {
  final PointsRepository repository;

  SpendPoints(this.repository);

  Future<Either<Failure, int>> call(SpendPointsParams params) async {
    return await repository.spendPoints(
      amount: params.amount,
      reason: params.reason,
      description: params.description,
      relatedNoteId: params.relatedNoteId,
    );
  }
}

class SpendPointsParams {
  final int amount;
  final String reason;
  final String? description;
  final int? relatedNoteId;

  const SpendPointsParams({
    required this.amount,
    required this.reason,
    this.description,
    this.relatedNoteId,
  });
}
