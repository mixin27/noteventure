import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'dart:developer' as developer;

import '../../callback/sync_callback_dispatcher.dart';
import '../../domain/repositories/background_sync_repository.dart';
import '../services/work_manager_service.dart';

@LazySingleton(as: BackgroundSyncRepository)
class BackgroundSyncRepositoryImpl implements BackgroundSyncRepository {
  final WorkManagerService _workManagerService;

  BackgroundSyncRepositoryImpl(this._workManagerService);

  @override
  Future<Either<Failure, void>> initialize({
    Duration syncFrequency = const Duration(minutes: 15),
    bool enableDebugMode = false,
  }) async {
    try {
      await _workManagerService.initialize(
        callbackDispatcher: syncCallbackDispatcher,
        enableDebugMode: enableDebugMode,
      );
      await _workManagerService.registerPeriodicSync(
        syncFrequency: syncFrequency,
      );

      developer.log('[BackgroundSync] Initialized successfully');
      return const Right(null);
    } catch (e) {
      developer.log('[BackgroundSync] Initialization failed: $e');
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerPeriodicSync({
    Duration syncFrequency = const Duration(minutes: 15),
  }) async {
    try {
      await _workManagerService.registerPeriodicSync(
        syncFrequency: syncFrequency,
      );
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> triggerImmediateSync() async {
    try {
      await _workManagerService.triggerImmediateSync();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelAllSyncTasks() async {
    try {
      await _workManagerService.cancelAllSyncTasks();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelPeriodicSync() async {
    try {
      await _workManagerService.cancelPeriodicSync();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isBackgroundSyncEnabled() async {
    try {
      return Right(_workManagerService.isInitialized);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateSyncFrequency(Duration frequency) async {
    try {
      await _workManagerService.cancelPeriodicSync();
      await _workManagerService.registerPeriodicSync(syncFrequency: frequency);
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
