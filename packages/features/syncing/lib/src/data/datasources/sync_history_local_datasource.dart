import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:drift/drift.dart';

import '../../domain/entities/sync_log.dart';
import '../../domain/entities/sync_result.dart';
import '../models/sync_log_model.dart';

abstract class SyncHistoryLocalDataSource {
  Stream<List<SyncLogModel>> watchAllSyncHistory();
  Future<SyncLogModel> createSync({
    required SyncType syncType,
    required bool success,
    SyncResult? result,
    String? error,
    required Duration duration,
  });
  Future<List<SyncLogModel>> getAllSyncHistory();
  Future<int> clearAll();
}

class SyncHistoryLocalDataSourceImpl implements SyncHistoryLocalDataSource {
  final SyncLogsDao syncLogDao;

  const SyncHistoryLocalDataSourceImpl(this.syncLogDao);

  @override
  Future<SyncLogModel> createSync({
    required SyncType syncType,
    required bool success,
    SyncResult? result,
    String? error,
    required Duration duration,
  }) async {
    final id = uuid.v4();
    final companion = SyncLogsCompanion.insert(
      id: Value(id),
      syncType: syncType.name,
      success: success,
      errorMessage: Value(error),
      notesSynced: result != null ? Value(result.notesSynced) : Value.absent(),
      transactionsSynced: result != null
          ? Value(result.transactionsSynced)
          : Value.absent(),
      progressSynced: result != null
          ? Value(result.progressSynced)
          : Value.absent(),
      conflictsFound: result != null
          ? Value(result.conflictsFound)
          : Value.absent(),
      durationMs: Value(duration.inMilliseconds),
      syncedAt: result != null ? Value(result.syncedAt) : Value.absent(),
    );

    await syncLogDao.createSyncLog(companion);

    final syncLog = await syncLogDao.getSyncLogById(id);
    if (syncLog == null) {
      throw const DatabaseException('Failed to create sync log');
    }

    return SyncLogModel.fromDrift(syncLog);
  }

  @override
  Future<List<SyncLogModel>> getAllSyncHistory() async {
    final syncLogs = await syncLogDao.getAllSyncLogs();
    return syncLogs.map((note) => SyncLogModel.fromDrift(note)).toList();
  }

  @override
  Future<int> clearAll() async {
    return syncLogDao.clearAll();
  }

  @override
  Stream<List<SyncLogModel>> watchAllSyncHistory() {
    return syncLogDao.watchAllSyncLogs().map((logs) {
      return logs.map((log) => SyncLogModel.fromDrift(log)).toList();
    });
  }
}
