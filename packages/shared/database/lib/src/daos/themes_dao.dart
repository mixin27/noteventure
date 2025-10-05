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
      // Default - Light (free, active)
      ThemesCompanion.insert(
        themeKey: 'default_light',
        name: 'Default',
        description: 'Classic Noteventure theme',
        unlockCost: 0,
        isUnlocked: const Value(true),
        isActive: const Value(true),
        primaryColor: '#6366F1',
        secondaryColor: '#8B5CF6',
        backgroundColor: '#FFFFFF',
        surfaceColor: '#F3F4F6',
        themeStyle: 'light',
      ),

      // Default - Dark (free)
      ThemesCompanion.insert(
        themeKey: 'default_dark',
        name: 'Default Dark',
        description: 'Classic Noteventure dark theme',
        unlockCost: 0,
        isUnlocked: const Value(true),
        primaryColor: '#818CF8',
        secondaryColor: '#A78BFA',
        backgroundColor: '#0F172A',
        surfaceColor: '#1E293B',
        themeStyle: 'dark',
      ),
      // Retro Terminal - Light
      ThemesCompanion.insert(
        themeKey: 'retro_light',
        name: 'Retro Terminal',
        description: 'Green on beige, vintage computer',
        unlockCost: 100,
        primaryColor: '#2D5016',
        secondaryColor: '#4A7C2C',
        backgroundColor: '#F5F5DC',
        surfaceColor: '#E8E8D0',
        themeStyle: 'light',
      ),

      // Retro Terminal - Dark
      ThemesCompanion.insert(
        themeKey: 'retro_dark',
        name: 'Retro Terminal Dark',
        description: 'Green on black, Matrix vibes',
        unlockCost: 100,
        primaryColor: '#00FF00',
        secondaryColor: '#39FF14',
        backgroundColor: '#000000',
        surfaceColor: '#0A0A0A',
        themeStyle: 'dark',
      ),

      // Vaporwave - Light
      ThemesCompanion.insert(
        themeKey: 'vaporwave_light',
        name: 'Vaporwave',
        description: 'Pastel pink and cyan dreams',
        unlockCost: 150,
        primaryColor: '#FFB3D9',
        secondaryColor: '#B3E5FC',
        backgroundColor: '#FFF0F5',
        surfaceColor: '#FFE4F0',
        themeStyle: 'light',
      ),

      // Vaporwave - Dark
      ThemesCompanion.insert(
        themeKey: 'vaporwave_dark',
        name: 'Vaporwave Dark',
        description: 'Neon pink and cyan aesthetic',
        unlockCost: 150,
        primaryColor: '#FF71CE',
        secondaryColor: '#01CDFE',
        backgroundColor: '#2E1A47',
        surfaceColor: '#3D2458',
        themeStyle: 'dark',
      ),

      // Brutalist - Light
      ThemesCompanion.insert(
        themeKey: 'brutalist_light',
        name: 'Brutalist',
        description: 'Raw concrete and stark contrast',
        unlockCost: 75,
        primaryColor: '#000000',
        secondaryColor: '#424242',
        backgroundColor: '#F5F5F5',
        surfaceColor: '#E0E0E0',
        themeStyle: 'light',
      ),

      // Brutalist - Dark
      ThemesCompanion.insert(
        themeKey: 'brutalist_dark',
        name: 'Brutalist Dark',
        description: 'Dark concrete brutalism',
        unlockCost: 75,
        primaryColor: '#BDBDBD',
        secondaryColor: '#9E9E9E',
        backgroundColor: '#121212',
        surfaceColor: '#1E1E1E',
        themeStyle: 'dark',
      ),

      // Comic Book - Light
      ThemesCompanion.insert(
        themeKey: 'comic_light',
        name: 'Comic Book',
        description: 'POW! BAM! Colorful action',
        unlockCost: 200,
        primaryColor: '#FF0000',
        secondaryColor: '#FFD700',
        backgroundColor: '#FFFFFF',
        surfaceColor: '#FFF9C4',
        themeStyle: 'light',
      ),

      // Comic Book - Dark
      ThemesCompanion.insert(
        themeKey: 'comic_dark',
        name: 'Comic Book Dark',
        description: 'Dark superhero noir',
        unlockCost: 200,
        primaryColor: '#FF5252',
        secondaryColor: '#FFD740',
        backgroundColor: '#1A1A1A',
        surfaceColor: '#2D2D2D',
        themeStyle: 'dark',
      ),

      // Handwritten - Light
      ThemesCompanion.insert(
        themeKey: 'handwritten_light',
        name: 'Handwritten',
        description: 'Notebook paper aesthetic',
        unlockCost: 125,
        primaryColor: '#1976D2',
        secondaryColor: '#388E3C',
        backgroundColor: '#FFF8DC',
        surfaceColor: '#FFFACD',
        themeStyle: 'light',
      ),

      // Handwritten - Dark
      ThemesCompanion.insert(
        themeKey: 'handwritten_dark',
        name: 'Handwritten Dark',
        description: 'Dark journal pages',
        unlockCost: 125,
        primaryColor: '#64B5F6',
        secondaryColor: '#81C784',
        backgroundColor: '#2C2416',
        surfaceColor: '#3D3424',
        themeStyle: 'dark',
      ),

      // Neon Cyberpunk - Light (unusual but possible)
      ThemesCompanion.insert(
        themeKey: 'cyberpunk_light',
        name: 'Cyberpunk',
        description: 'Bright future neon',
        unlockCost: 250,
        primaryColor: '#00E5FF',
        secondaryColor: '#E040FB',
        backgroundColor: '#F5F5F5',
        surfaceColor: '#E8E8E8',
        themeStyle: 'light',
      ),

      // Neon Cyberpunk - Dark
      ThemesCompanion.insert(
        themeKey: 'cyberpunk_dark',
        name: 'Cyberpunk Dark',
        description: 'Dark city neon nights',
        unlockCost: 250,
        primaryColor: '#00F0FF',
        secondaryColor: '#FF00FF',
        backgroundColor: '#0D0221',
        surfaceColor: '#1B0638',
        themeStyle: 'dark',
      ),
    ];
  }
}
