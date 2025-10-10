import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

abstract class SyncRepository {
  /// Perform full sync (push local changes, then pull server changes)
  Future<Either<Failure, SyncResult>> sync();

  /// Pull data from server only
  Future<Either<Failure, SyncResult>> pullFromServer();

  /// Push local data to server only
  Future<Either<Failure, DateTime>> pushToServer();

  /// Get last sync timestamp
  Future<Either<Failure, DateTime?>> getLastSyncTime();
}

/// Result of a sync operation
class SyncResult {
  final int notesSynced;
  final int transactionsSynced;
  final bool progressSynced;
  final int conflictsFound;
  final DateTime syncedAt;

  const SyncResult({
    required this.notesSynced,
    required this.transactionsSynced,
    required this.progressSynced,
    required this.conflictsFound,
    required this.syncedAt,
  });
}
