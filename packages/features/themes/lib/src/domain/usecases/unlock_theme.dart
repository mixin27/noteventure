import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/themes_repository.dart';

class UnlockTheme {
  final ThemesRepository repository;
  UnlockTheme(this.repository);

  Future<Either<Failure, Unit>> call(String key) {
    return repository.unlockTheme(key);
  }
}
