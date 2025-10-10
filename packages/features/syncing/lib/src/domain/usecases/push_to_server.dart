import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/sync_repository.dart';

class PushToServer {
  final SyncRepository repository;

  PushToServer(this.repository);

  Future<Either<Failure, DateTime>> call() async {
    return await repository.pushToServer();
  }
}
