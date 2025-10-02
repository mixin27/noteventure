import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class UpdateSettings {
  final SettingsRepository repository;

  UpdateSettings(this.repository);

  Future<Either<Failure, Unit>> call(AppSettings settings) {
    return repository.updateSettings(settings);
  }
}
