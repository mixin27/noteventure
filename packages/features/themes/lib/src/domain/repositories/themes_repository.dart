import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/app_theme.dart';

abstract class ThemesRepository {
  Future<Either<Failure, List<AppTheme>>> getAllThemes();
  Future<Either<Failure, List<AppTheme>>> getUnlockedThemes();
  Future<Either<Failure, List<AppTheme>>> getLockedThemes();
  Future<Either<Failure, AppTheme?>> getActiveTheme();
  Future<Either<Failure, AppTheme>> getThemeByKey(String key);
  Future<Either<Failure, Unit>> unlockTheme(String key);
  Future<Either<Failure, Unit>> activateTheme(String key);
  Future<Either<Failure, Unit>> initializeThemes();
  Stream<List<AppTheme>> watchThemes();
  Stream<AppTheme?> watchActiveTheme();
}
