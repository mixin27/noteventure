import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/sync_repository.dart';

class SyncData {
  final SyncRepository repository;

  SyncData(this.repository);

  Future<Either<Failure, SyncResult>> call() async {
    return await repository.sync();
  }
}
