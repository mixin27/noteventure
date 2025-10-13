import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/sync_log.dart';
import '../entities/sync_result.dart';

abstract class SyncHistoryRepository {
  Future<Either<Failure, List<SyncLog>>> getAllSyncLogs();
  Stream<List<SyncLog>> watchAllSyncLogs();
  Future<Either<Failure, int>> clearSyncHistory();
  Future<Either<Failure, SyncLog>> logSync({
    required SyncType syncType,
    required bool success,
    SyncResult? result,
    String? error,
    required Duration duration,
  });
}
