import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/sync_logs_table.dart';

part 'sync_logs_dao.g.dart';

@DriftAccessor(tables: [SyncLogs])
class SyncLogsDao extends DatabaseAccessor<AppDatabase>
    with _$SyncLogsDaoMixin {
  SyncLogsDao(super.db);

  Future<int> createSyncLog(SyncLogsCompanion log) async {
    return into(syncLogs).insert(log);
  }

  Future<SyncLog?> getSyncLogById(String id) async {
    return (select(
      syncLogs,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Get all sync logs
  Future<List<SyncLog>> getAllSyncLogs() {
    return (select(syncLogs)..orderBy([
          (tbl) =>
              OrderingTerm(expression: tbl.syncedAt, mode: OrderingMode.desc),
        ]))
        .get();
  }

  /// Watch all sync log (for real-time updates)
  Stream<List<SyncLog>> watchAllSyncLogs() {
    return (select(syncLogs)..orderBy([
          (tbl) =>
              OrderingTerm(expression: tbl.syncedAt, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  /// Watch sync log by ID
  Stream<SyncLog?> watchSyncLogById(String id) {
    return (select(
      syncLogs,
    )..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }

  Future<int> clearAll() async {
    return await delete(syncLogs).go();
  }
}
