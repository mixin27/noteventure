import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/sync_repository.dart';

class PullFromServer {
  final SyncRepository repository;

  PullFromServer(this.repository);

  Future<Either<Failure, SyncResult>> call() async {
    return await repository.pullFromServer();
  }
}
