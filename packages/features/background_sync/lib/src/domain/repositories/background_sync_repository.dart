import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class BackgroundSyncRepository {
  /// Initialize WorkManager
  Future<Either<Failure, void>> initialize({
    Duration syncFrequency = const Duration(minutes: 15),
    bool enableDebugMode = false,
  });

  /// Register periodic sync task
  Future<Either<Failure, void>> registerPeriodicSync({
    Duration syncFrequency = const Duration(minutes: 15),
  });

  /// Trigger immediate one-time sync
  Future<Either<Failure, void>> triggerImmediateSync();

  /// Cancel all sync tasks
  Future<Either<Failure, void>> cancelAllSyncTasks();

  /// Cancel only periodic sync
  Future<Either<Failure, void>> cancelPeriodicSync();

  /// Check if background sync is enabled
  Future<Either<Failure, bool>> isBackgroundSyncEnabled();

  /// Update sync frequency
  Future<Either<Failure, void>> updateSyncFrequency(Duration frequency);
}
