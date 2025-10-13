import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/sync_result.dart';

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
