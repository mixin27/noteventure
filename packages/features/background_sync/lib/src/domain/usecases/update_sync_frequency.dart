import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/background_sync_repository.dart';

@lazySingleton
class UpdateSyncFrequency {
  final BackgroundSyncRepository _repository;

  UpdateSyncFrequency(this._repository);

  Future<Either<Failure, void>> call(Duration frequency) async {
    return await _repository.updateSyncFrequency(frequency);
  }
}
