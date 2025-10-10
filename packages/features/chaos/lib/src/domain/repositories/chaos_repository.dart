import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/chaos_event_entity.dart';

abstract class ChaosRepository {
  Future<Either<Failure, List<ChaosEventEntity>>> getAllEvents();
  Future<Either<Failure, List<ChaosEventEntity>>> getRecentEvents({int limit});
  Future<Either<Failure, ChaosEventEntity>> triggerRandomEvent();
  Future<Either<Failure, Unit>> resolveEvent(String id);
  Future<Either<Failure, Unit>> disableChaosTemporarily(Duration duration);
  Stream<List<ChaosEventEntity>> watchEvents();
}
