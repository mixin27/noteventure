import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../domain/entities/point_transaction.dart';
import '../../domain/repositories/points_repository.dart';
import '../datasources/points_local_datasource.dart';

class PointsRepositoryImpl implements PointsRepository {
  final PointsLocalDataSource localDataSource;

  PointsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, int>> getPointBalance() async {
    try {
      final balance = await localDataSource.getPointBalance();
      return Right(balance);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> hasEnoughPoints(int required) async {
    try {
      final hasEnough = await localDataSource.hasEnoughPoints(required);
      return Right(hasEnough);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> spendPoints({
    required int amount,
    required String reason,
    String? description,
    int? relatedNoteId,
  }) async {
    try {
      final newBalance = await localDataSource.spendPoints(
        amount: amount,
        reason: reason,
        description: description,
        relatedNoteId: relatedNoteId,
      );
      return Right(newBalance);
    } on InsufficientPointsException catch (e) {
      return Left(
        InsufficientPointsFailure(required: e.required, current: e.current),
      );
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> earnPoints({
    required int amount,
    required String reason,
    String? description,
    int? relatedChallengeId,
  }) async {
    try {
      final newBalance = await localDataSource.earnPoints(
        amount: amount,
        reason: reason,
        description: description,
        relatedChallengeId: relatedChallengeId,
      );
      return Right(newBalance);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PointTransaction>>> getRecentTransactions(
    int limit,
  ) async {
    try {
      final transactions = await localDataSource.getRecentTransactions(limit);
      return Right(transactions.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PointTransaction>>> getAllTransactions() async {
    try {
      final transactions = await localDataSource.getAllTransactions();
      return Right(transactions.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, int>> watchPointBalance() {
    try {
      return localDataSource.watchPointBalance().map(
        (balance) => Right(balance),
      );
    } catch (e) {
      return Stream.value(Left(UnknownFailure(e.toString())));
    }
  }
}
