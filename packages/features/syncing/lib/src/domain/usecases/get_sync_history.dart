import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/sync_log.dart';
import '../repositories/sync_history_repository.dart';

class GetSyncHistory {
  final SyncHistoryRepository repository;

  const GetSyncHistory(this.repository);

  Future<Either<Failure, List<SyncLog>>> call() async {
    return await repository.getAllSyncLogs();
  }
}
