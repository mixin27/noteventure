import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../entities/point_transaction.dart';

abstract class PointsRepository {
  /// Get current point balance
  Future<Either<Failure, int>> getPointBalance();

  /// Check if user has enough points
  Future<Either<Failure, bool>> hasEnoughPoints(int required);

  /// Spend points
  Future<Either<Failure, int>> spendPoints({
    required int amount,
    required String reason,
    String? description,
    String? relatedNoteId,
  });

  /// Earn points
  Future<Either<Failure, int>> earnPoints({
    required int amount,
    required String reason,
    String? description,
    String? relatedChallengeId,
  });

  /// Get recent transactions
  Future<Either<Failure, List<PointTransaction>>> getRecentTransactions(
    int limit,
  );

  /// Get all transactions
  Future<Either<Failure, List<PointTransaction>>> getAllTransactions();

  /// Watch point balance (stream)
  Stream<Either<Failure, int>> watchPointBalance();
}
