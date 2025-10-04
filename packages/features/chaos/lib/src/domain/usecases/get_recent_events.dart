import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/chaos_event_entity.dart';
import '../repositories/chaos_repository.dart';

class GetRecentEvents {
  final ChaosRepository repository;
  GetRecentEvents(this.repository);

  Future<Either<Failure, List<ChaosEventEntity>>> call({int limit = 10}) {
    return repository.getRecentEvents(limit: limit);
  }
}
