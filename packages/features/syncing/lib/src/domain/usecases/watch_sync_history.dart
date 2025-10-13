import '../entities/sync_log.dart';
import '../repositories/sync_history_repository.dart';

class WatchSyncHistory {
  final SyncHistoryRepository repository;

  const WatchSyncHistory(this.repository);

  Stream<List<SyncLog>> call() {
    return repository.watchAllSyncLogs();
  }
}
