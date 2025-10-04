import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/themes_repository.dart';

class ActivateTheme {
  final ThemesRepository repository;
  ActivateTheme(this.repository);

  Future<Either<Failure, Unit>> call(String key) {
    return repository.activateTheme(key);
  }
}
