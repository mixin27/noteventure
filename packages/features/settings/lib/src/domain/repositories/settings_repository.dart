import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_settings.dart';

abstract class SettingsRepository {
  Future<Either<Failure, AppSettings>> getSettings();
  Future<Either<Failure, Unit>> updateSettings(AppSettings settings);
  Future<Either<Failure, Unit>> resetSettings();
  Stream<AppSettings> watchSettings();
}
