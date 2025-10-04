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

  Future<int> getThemesCount() async {
    final countQuery = selectOnly(themes)..addColumns([themes.id.count()]);
    final result = await countQuery.getSingle();
    return result.read(themes.id.count()) ?? 0;
  }

  // Insert default themes
  Future<void> insertDefaultThemes() async {
    await batch((batch) {
      batch.insertAll(
        themes,
        _getDefaultThemes(),
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  List<ThemesCompanion> _getDefaultThemes() {
    return [
      // Default theme (free, unlocked, active)
      ThemesCompanion.insert(
        themeKey: 'default',
        name: 'Default',
        description: 'Classic Noteventure theme',
        unlockCost: 0,
        isUnlocked: Value(true),
        unlockedAt: Value(DateTime.now()),
        isActive: Value(true),
        primaryColor: '#6366F1', // Indigo
        secondaryColor: '#8B5CF6', // Purple
        backgroundColor: '#FFFFFF',
        surfaceColor: '#F9FAFB',
        themeStyle: 'light',
      ),

      // Retro Terminal
      ThemesCompanion.insert(
        themeKey: 'retro_terminal',
        name: 'Retro Terminal',
        description: 'Green phosphor CRT aesthetic',
        unlockCost: 100,
        isUnlocked: Value(false),
        isActive: Value(false),
        primaryColor: '#00FF00', // Bright green
        secondaryColor: '#39FF14', // Neon green
        backgroundColor: '#0A0A0A',
        surfaceColor: '#1A1A1A',
        themeStyle: 'dark',
      ),

      // Vaporwave
      ThemesCompanion.insert(
        themeKey: 'vaporwave',
        name: 'Vaporwave',
        description: 'A e s t h e t i c vibes',
        unlockCost: 150,
        isUnlocked: Value(false),
        isActive: Value(false),
        primaryColor: '#FF71CE', // Hot pink
        secondaryColor: '#01CDFE', // Cyan
        backgroundColor: '#2E1A47',
        surfaceColor: '#3D2458',
        themeStyle: 'dark',
      ),

      // Brutalist
      ThemesCompanion.insert(
        themeKey: 'brutalist',
        name: 'Brutalist',
        description: 'Raw, minimalist design',
        unlockCost: 75,
        isUnlocked: Value(false),
        isActive: Value(false),
        primaryColor: '#000000', // Black
        secondaryColor: '#FF0000', // Red
        backgroundColor: '#E5E5E5',
        surfaceColor: '#FFFFFF',
        themeStyle: 'light',
      ),

      // Comic Book
      ThemesCompanion.insert(
        themeKey: 'comic_book',
        name: 'Comic Book',
        description: 'Bold, colorful, action-packed',
        unlockCost: 200,
        isUnlocked: Value(false),
        isActive: Value(false),
        primaryColor: '#FFD700', // Gold
        secondaryColor: '#FF4500', // Orange red
        backgroundColor: '#FFF5E1',
        surfaceColor: '#FFFACD',
        themeStyle: 'light',
      ),

      // Handwritten
      ThemesCompanion.insert(
        themeKey: 'handwritten',
        name: 'Handwritten',
        description: 'Personal touch aesthetic',
        unlockCost: 125,
        isUnlocked: Value(false),
        isActive: Value(false),
        primaryColor: '#3B5998', // Dark blue
        secondaryColor: '#8B4513', // Brown
        backgroundColor: '#FFF8DC',
        surfaceColor: '#FFFAF0',
        themeStyle: 'light',
      ),

      // Neon Cyberpunk
      ThemesCompanion.insert(
        themeKey: 'neon_cyberpunk',
        name: 'Neon Cyberpunk',
        description: 'Futuristic neon cityscape',
        unlockCost: 250,
        isUnlocked: Value(false),
        isActive: Value(false),
        primaryColor: '#00FFFF', // Cyan
        secondaryColor: '#FF00FF', // Magenta
        backgroundColor: '#0D0221',
        surfaceColor: '#1B0638',
        themeStyle: 'dark',
      ),
    ];
  }
}
