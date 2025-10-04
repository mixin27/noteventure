import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/app_theme.dart';
import '../../domain/repositories/themes_repository.dart';
import '../datasources/themes_local_datasource.dart';

class ThemesRepositoryImpl implements ThemesRepository {
  final ThemesLocalDataSource localDataSource;

  ThemesRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<AppTheme>>> getAllThemes() async {
    try {
      final themes = await localDataSource.getAllThemes();
      return Right(themes.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppTheme>>> getUnlockedThemes() async {
    try {
      final themes = await localDataSource.getUnlockedThemes();
      return Right(themes.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppTheme>>> getLockedThemes() async {
    try {
      final themes = await localDataSource.getLockedThemes();
      return Right(themes.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppTheme?>> getActiveTheme() async {
    try {
      final theme = await localDataSource.getActiveTheme();
      return Right(theme?.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppTheme>> getThemeByKey(String key) async {
    try {
      final theme = await localDataSource.getThemeByKey(key);
      if (theme == null) {
        return Left(CacheFailure('Theme not found: $key'));
      }
      return Right(theme.toEntity());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> unlockTheme(String key) async {
    try {
      await localDataSource.unlockTheme(key);

      // Emit theme unlocked event
      AppEventBus().emit(
        ThemeUnlockedEvent(
          themeKey: key,
          themeName: '', // Would need to fetch name
        ),
      );

      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> activateTheme(String key) async {
    try {
      await localDataSource.activateTheme(key);

      // Emit theme changed event
      AppEventBus().emit(ThemeChangedEvent(key));

      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> initializeThemes() async {
    try {
      await localDataSource.initializeThemes();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Stream<List<AppTheme>> watchThemes() {
    return localDataSource.watchThemes().map(
      (list) => list.map((m) => m.toEntity()).toList(),
    );
  }

  @override
  Stream<AppTheme?> watchActiveTheme() {
    return localDataSource.watchActiveTheme().map((m) => m?.toEntity());
  }
}
