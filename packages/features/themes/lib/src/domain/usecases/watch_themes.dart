import '../entities/app_theme.dart';
import '../repositories/themes_repository.dart';

class WatchThemes {
  final ThemesRepository repository;
  WatchThemes(this.repository);

  Stream<List<AppTheme>> call() {
    return repository.watchThemes();
  }
}
