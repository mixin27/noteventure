import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';
import '../models/app_settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    try {
      final settings = await localDataSource.getSettings();
      return Right(settings.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateSettings(AppSettings settings) async {
    try {
      final model = AppSettingsModel.fromEntity(settings);
      await localDataSource.updateSettings(model);

      // No EventBus! Settings changes are propagated via watchSettings() stream
      // Other features should subscribe to watchSettings() directly

      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetSettings() async {
    try {
      await localDataSource.resetSettings();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Stream<AppSettings> watchSettings() {
    return localDataSource.watchSettings().map((model) => model.toEntity());
  }
}
