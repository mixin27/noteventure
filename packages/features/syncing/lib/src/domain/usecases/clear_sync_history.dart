import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/sync_history_repository.dart';

class ClearSyncHistory {
  final SyncHistoryRepository repository;

  const ClearSyncHistory(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.clearSyncHistory();
  }
}
