import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/themes_table.dart';

part 'themes_dao.g.dart';

@DriftAccessor(tables: [Themes])
class ThemesDao extends DatabaseAccessor<AppDatabase> with _$ThemesDaoMixin {
  ThemesDao(super.db);

  /// Get all themes
  Future<List<Theme>> getAllThemes() {
    return (select(
      themes,
    )..orderBy([(tbl) => OrderingTerm(expression: tbl.unlockCost)])).get();
  }

  /// Get unlocked themes
  Future<List<Theme>> getUnlockedThemes() {
    return (select(themes)..where((tbl) => tbl.isUnlocked.equals(true))).get();
  }

  /// Get locked themes
  Future<List<Theme>> getLockedThemes() {
    return (select(themes)..where((tbl) => tbl.isUnlocked.equals(false))).get();
  }

  /// Get active theme
  Future<Theme?> getActiveTheme() {
    return (select(
      themes,
    )..where((tbl) => tbl.isActive.equals(true))).getSingleOrNull();
  }

  /// Get theme by key
  Future<Theme?> getThemeByKey(String key) {
    return (select(
      themes,
    )..where((tbl) => tbl.themeKey.equals(key))).getSingleOrNull();
  }

  /// Unlock theme
  Future<int> unlockTheme(String themeKey) {
    return (update(
      themes,
    )..where((tbl) => tbl.themeKey.equals(themeKey))).write(
      ThemesCompanion(
        isUnlocked: const Value(true),
        unlockedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Set active theme
  Future<void> setActiveTheme(String themeKey) async {
    // First, deactivate all themes
    await (update(themes)..where((tbl) => tbl.isActive.equals(true))).write(
      const ThemesCompanion(isActive: Value(false)),
    );

    // Then activate the selected theme
    await (update(themes)..where((tbl) => tbl.themeKey.equals(themeKey))).write(
      const ThemesCompanion(isActive: Value(true)),
    );
  }

  /// Watch active theme
  Stream<Theme?> watchActiveTheme() {
    return (select(
      themes,
    )..where((tbl) => tbl.isActive.equals(true))).watchSingleOrNull();
  }

  /// Watch all themes
  Stream<List<Theme>> watchAllThemes() {
    return (select(
      themes,
    )..orderBy([(tbl) => OrderingTerm(expression: tbl.unlockCost)])).watch();
  }
}
