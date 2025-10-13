import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/background_sync_repository.dart';

@lazySingleton
class InitializeBackgroundSync {
  final BackgroundSyncRepository _repository;

  InitializeBackgroundSync(this._repository);

  Future<Either<Failure, void>> call({
    Duration syncFrequency = const Duration(minutes: 15),
    bool enableDebugMode = false,
  }) async {
    return await _repository.initialize(
      syncFrequency: syncFrequency,
      enableDebugMode: enableDebugMode,
    );
  }
}
