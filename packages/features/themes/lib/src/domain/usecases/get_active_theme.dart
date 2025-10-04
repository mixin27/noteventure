import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_theme.dart';
import '../repositories/themes_repository.dart';

class GetActiveTheme {
  final ThemesRepository repository;
  GetActiveTheme(this.repository);

  Future<Either<Failure, AppTheme?>> call() {
    return repository.getActiveTheme();
  }
}
