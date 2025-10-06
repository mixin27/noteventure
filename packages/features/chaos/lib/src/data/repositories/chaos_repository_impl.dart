import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/chaos_event_entity.dart';
import '../../domain/repositories/chaos_repository.dart';
import '../datasources/chaos_local_datasource.dart';

class ChaosRepositoryImpl implements ChaosRepository {
  final ChaosLocalDataSource localDataSource;

  ChaosRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<ChaosEventEntity>>> getAllEvents() async {
    try {
      final events = await localDataSource.getAllEvents();
      return Right(events.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChaosEventEntity>>> getRecentEvents({
    int limit = 10,
  }) async {
    try {
      final events = await localDataSource.getRecentEvents(limit: limit);
      return Right(events.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChaosEventEntity>> triggerRandomEvent() async {
    try {
      final event = await localDataSource.triggerRandomEvent();
      return Right(event.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> resolveEvent(int id) async {
    try {
      await localDataSource.resolveEvent(id);
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> disableChaosTemporarily(
    Duration duration,
  ) async {
    // This would need to be implemented with settings
    // For now, just return success
    return const Right(unit);
  }

  @override
  Stream<List<ChaosEventEntity>> watchEvents() {
    return localDataSource.watchEvents().map(
      (list) => list.map((m) => m.toEntity()).toList(),
    );
  }
}
