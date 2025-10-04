import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_theme.dart';
import '../repositories/themes_repository.dart';

class GetUnlockedThemes {
  final ThemesRepository repository;
  GetUnlockedThemes(this.repository);

  Future<Either<Failure, List<AppTheme>>> call() {
    return repository.getUnlockedThemes();
  }
}
