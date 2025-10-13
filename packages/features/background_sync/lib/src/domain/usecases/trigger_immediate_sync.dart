import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/background_sync_repository.dart';

@lazySingleton
class TriggerImmediateSync {
  final BackgroundSyncRepository _repository;

  TriggerImmediateSync(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.triggerImmediateSync();
  }
}
