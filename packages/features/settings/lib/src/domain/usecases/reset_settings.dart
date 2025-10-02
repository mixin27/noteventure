import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/settings_repository.dart';

class ResetSettings {
  final SettingsRepository repository;

  ResetSettings(this.repository);

  Future<Either<Failure, Unit>> call() {
    return repository.resetSettings();
  }
}
