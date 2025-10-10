import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/sync_repository.dart';

class GetLastSyncTime {
  final SyncRepository repository;

  GetLastSyncTime(this.repository);

  Future<Either<Failure, DateTime?>> call() async {
    return await repository.getLastSyncTime();
  }
}
