import 'package:database/database.dart';

import '../models/app_theme_model.dart';

abstract class ThemesLocalDataSource {
  Future<List<AppThemeModel>> getAllThemes();
  Future<List<AppThemeModel>> getUnlockedThemes();
  Future<List<AppThemeModel>> getLockedThemes();
  Future<AppThemeModel?> getActiveTheme();
  Future<AppThemeModel?> getThemeByKey(String key);
  Future<void> unlockTheme(String key);
  Future<void> activateTheme(String key);
  Future<void> initializeThemes();
  Stream<List<AppThemeModel>> watchThemes();
  Stream<AppThemeModel?> watchActiveTheme();
}

class ThemesLocalDataSourceImpl implements ThemesLocalDataSource {
  final ThemesDao themesDao;

  ThemesLocalDataSourceImpl(this.themesDao);

  @override
  Future<List<AppThemeModel>> getAllThemes() async {
    final themes = await themesDao.getAllThemes();
    return themes.map((t) => AppThemeModel.fromDrift(t)).toList();
  }

  @override
  Future<List<AppThemeModel>> getUnlockedThemes() async {
    final themes = await themesDao.getUnlockedThemes();
    return themes.map((t) => AppThemeModel.fromDrift(t)).toList();
  }

  @override
  Future<List<AppThemeModel>> getLockedThemes() async {
    final themes = await themesDao.getLockedThemes();
    return themes.map((t) => AppThemeModel.fromDrift(t)).toList();
  }

  @override
  Future<AppThemeModel?> getActiveTheme() async {
    final theme = await themesDao.getActiveTheme();
    return theme != null ? AppThemeModel.fromDrift(theme) : null;
  }

  @override
  Future<AppThemeModel?> getThemeByKey(String key) async {
    final theme = await themesDao.getThemeByKey(key);
    return theme != null ? AppThemeModel.fromDrift(theme) : null;
  }

  @override
  Future<void> unlockTheme(String key) async {
    await themesDao.unlockTheme(key);
  }

  @override
  Future<void> activateTheme(String key) async {
    await themesDao.setActiveTheme(key);
  }

  @override
  Future<void> initializeThemes() async {
    final count = await themesDao.getThemesCount();
    if (count == 0) {
      await themesDao.insertDefaultThemes();
    }
  }

  @override
  Stream<List<AppThemeModel>> watchThemes() {
    return themesDao.watchAllThemes().map(
      (list) => list.map((t) => AppThemeModel.fromDrift(t)).toList(),
    );
  }

  @override
  Stream<AppThemeModel?> watchActiveTheme() {
    return themesDao.watchActiveTheme().map(
      (theme) => theme != null ? AppThemeModel.fromDrift(theme) : null,
    );
  }
}
