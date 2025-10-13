import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/background_sync_repository.dart';

@lazySingleton
class CancelBackgroundSync {
  final BackgroundSyncRepository _repository;

  CancelBackgroundSync(this._repository);

  Future<Either<Failure, void>> call() async {
    return await _repository.cancelPeriodicSync();
  }
}
