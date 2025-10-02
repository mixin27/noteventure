import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class WatchSettings {
  final SettingsRepository repository;

  WatchSettings(this.repository);

  Stream<AppSettings> call() {
    return repository.watchSettings();
  }
}
