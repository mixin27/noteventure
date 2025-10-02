import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../domain/entities/user_progress.dart';
import '../../domain/repositories/progress_repository.dart';
import '../datasources/progress_local_datasource.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final ProgressLocalDataSource localDataSource;

  ProgressRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, UserProgress>> getUserProgress() async {
    try {
      final progress = await localDataSource.getUserProgress();
      return Right(progress.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> addXp(int amount) async {
    try {
      final result = await localDataSource.addXp(amount);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProgress>> updateStreak(bool success) async {
    try {
      final progress = await localDataSource.updateStreak(success);
      return Right(progress.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> incrementChallengesSolved() async {
    try {
      await localDataSource.incrementChallengesSolved();
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> incrementChallengesFailed() async {
    try {
      await localDataSource.incrementChallengesFailed();
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> incrementNotesCreated() async {
    try {
      await localDataSource.incrementNotesCreated();
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> incrementNotesDeleted() async {
    try {
      await localDataSource.incrementNotesDeleted();
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, UserProgress>> watchProgress() {
    try {
      return localDataSource.watchProgress().map(
        (progress) => Right(progress.toEntity()),
      );
    } catch (e) {
      return Stream.value(Left(UnknownFailure(e.toString())));
    }
  }
}
