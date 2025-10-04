import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/themes_repository.dart';

class InitializeThemes {
  final ThemesRepository repository;
  InitializeThemes(this.repository);

  Future<Either<Failure, Unit>> call() {
    return repository.initializeThemes();
  }
}
