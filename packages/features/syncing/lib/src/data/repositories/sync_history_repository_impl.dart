import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:syncing/src/domain/entities/sync_result.dart';

import '../../domain/entities/sync_log.dart';
import '../../domain/repositories/sync_history_repository.dart';
import '../datasources/sync_history_local_datasource.dart';

class SyncHistoryRepositoryImpl implements SyncHistoryRepository {
  final SyncHistoryLocalDataSource localDataSource;

  const SyncHistoryRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, SyncLog>> logSync({
    required SyncType syncType,
    required bool success,
    SyncResult? result,
    String? error,
    required Duration duration,
  }) async {
    try {
      final createdLog = await localDataSource.createSync(
        syncType: syncType,
        success: success,
        result: result,
        error: error,
        duration: duration,
      );
      return Right(createdLog.toEntity());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SyncLog>>> getAllSyncLogs() async {
    try {
      final syncLogs = await localDataSource.getAllSyncHistory();
      return Right(syncLogs.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> clearSyncHistory() async {
    try {
      final result = await localDataSource.clearAll();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<List<SyncLog>> watchAllSyncLogs() {
    return localDataSource.watchAllSyncHistory();
  }
}
