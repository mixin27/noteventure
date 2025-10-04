import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/chaos_event_entity.dart';
import '../repositories/chaos_repository.dart';

class TriggerRandomEvent {
  final ChaosRepository repository;
  TriggerRandomEvent(this.repository);

  Future<Either<Failure, ChaosEventEntity>> call() {
    return repository.triggerRandomEvent();
  }
}
