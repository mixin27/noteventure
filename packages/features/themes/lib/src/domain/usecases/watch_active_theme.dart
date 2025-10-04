import '../entities/app_theme.dart';
import '../repositories/themes_repository.dart';

class WatchActiveTheme {
  final ThemesRepository repository;
  WatchActiveTheme(this.repository);

  Stream<AppTheme?> call() {
    return repository.watchActiveTheme();
  }
}
