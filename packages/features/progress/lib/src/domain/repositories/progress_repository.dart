import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/user_progress.dart';

abstract class ProgressRepository {
  /// Get user progress
  Future<Either<Failure, UserProgress>> getUserProgress();

  /// Add XP
  Future<Either<Failure, Map<String, dynamic>>> addXp(int amount);

  /// Update streak
  Future<Either<Failure, UserProgress>> updateStreak(bool success);

  /// Increment stats
  Future<Either<Failure, void>> incrementChallengesSolved();
  Future<Either<Failure, void>> incrementChallengesFailed();
  Future<Either<Failure, void>> incrementNotesCreated();
  Future<Either<Failure, void>> incrementNotesDeleted();

  /// Watch progress (stream)
  Stream<Either<Failure, UserProgress>> watchProgress();
}
