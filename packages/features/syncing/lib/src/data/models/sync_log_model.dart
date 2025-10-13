import 'package:database/database.dart' as db;

import '../../domain/entities/sync_log.dart';

class SyncLogModel extends SyncLog {
  const SyncLogModel({
    required super.id,
    required super.syncType,
    required super.success,
    required super.syncedAt,
    super.conflictsFound,
    super.durationMs,
    super.errorMessage,
    super.notesSynced,
    super.progressSynced,
    super.transactionsSynced,
  });

  factory SyncLogModel.fromDrift(db.SyncLog drift) {
    return SyncLogModel(
      id: drift.id,
      syncType: SyncType.fromString(drift.syncType),
      success: drift.success,
      syncedAt: drift.syncedAt,
      conflictsFound: drift.conflictsFound,
      durationMs: drift.durationMs,
      errorMessage: drift.errorMessage,
      notesSynced: drift.notesSynced,
      progressSynced: drift.progressSynced,
      transactionsSynced: drift.transactionsSynced,
    );
  }

  SyncLog toEntity() {
    return SyncLog(
      id: id,
      syncType: syncType,
      success: success,
      syncedAt: syncedAt,
      conflictsFound: conflictsFound,
      durationMs: durationMs,
      errorMessage: errorMessage,
      notesSynced: notesSynced,
      progressSynced: progressSynced,
      transactionsSynced: transactionsSynced,
    );
  }
}
