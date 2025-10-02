import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/app_settings_table.dart';

part 'app_settings_dao.g.dart';

@DriftAccessor(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.db);

  // ============================================================================
  // GET SETTING BY KEY
  // ============================================================================

  Future<String?> getSetting(String key) async {
    final query = select(appSettings)
      ..where((tbl) => tbl.settingKey.equals(key));
    final result = await query.getSingleOrNull();
    return result?.settingValue;
  }

  // ============================================================================
  // GET ALL SETTINGS
  // ============================================================================

  Future<Map<String, String>> getAllSettings() async {
    final allSettings = await select(appSettings).get();
    return {
      for (final setting in allSettings)
        setting.settingKey: setting.settingValue,
    };
  }

  // ============================================================================
  // UPDATE OR INSERT SETTING
  // ============================================================================

  Future<void> setSetting(String key, String value) async {
    final query = select(appSettings)
      ..where((tbl) => tbl.settingKey.equals(key));
    final setting = await query.getSingleOrNull();
    if (setting == null) {
      await into(appSettings).insertOnConflictUpdate(
        AppSettingsCompanion.insert(
          settingKey: key,
          settingValue: value,
          updatedAt: DateTime.now(),
        ),
      );
    } else {
      await into(appSettings).insertOnConflictUpdate(
        AppSettingsCompanion.insert(
          id: Value(setting.id),
          settingKey: key,
          settingValue: value,
          updatedAt: DateTime.now(),
        ),
      );
    }
  }

  // ============================================================================
  // UPDATE MULTIPLE SETTINGS IN TRANSACTION
  // ============================================================================

  Future<void> setMultipleSettings(Map<String, String> settings) async {
    await transaction(() async {
      for (final entry in settings.entries) {
        await setSetting(entry.key, entry.value);
      }
    });
  }

  // ============================================================================
  // DELETE SETTING BY KEY
  // ============================================================================

  Future<void> deleteSetting(String key) async {
    await (delete(
      appSettings,
    )..where((tbl) => tbl.settingKey.equals(key))).go();
  }

  // ============================================================================
  // DELETE ALL SETTINGS
  // ============================================================================

  Future<void> deleteAllSettings() async {
    await delete(appSettings).go();
  }

  // ============================================================================
  // CHECK IF SETTING EXISTS
  // ============================================================================

  Future<bool> settingExists(String key) async {
    final query = select(appSettings)
      ..where((tbl) => tbl.settingKey.equals(key));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  // ============================================================================
  // WATCH SINGLE SETTING
  // ============================================================================

  Stream<String?> watchSetting(String key) {
    final query = select(appSettings)
      ..where((tbl) => tbl.settingKey.equals(key));
    return query.watchSingleOrNull().map((row) => row?.settingValue);
  }

  // ============================================================================
  // WATCH ALL SETTINGS
  // ============================================================================

  Stream<Map<String, String>> watchAllSettings() {
    return select(appSettings).watch().map((rows) {
      return {for (final row in rows) row.settingKey: row.settingValue};
    });
  }

  // ============================================================================
  // GET SETTING WITH DEFAULT
  // ============================================================================

  Future<String> getSettingWithDefault(String key, String defaultValue) async {
    final value = await getSetting(key);
    return value ?? defaultValue;
  }

  // ============================================================================
  // TYPED GETTERS (Helper methods for common types)
  // ============================================================================

  Future<bool> getBoolSetting(String key, {bool defaultValue = false}) async {
    final value = await getSetting(key);
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  Future<int> getIntSetting(String key, {int defaultValue = 0}) async {
    final value = await getSetting(key);
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }

  Future<double> getDoubleSetting(
    String key, {
    double defaultValue = 0.0,
  }) async {
    final value = await getSetting(key);
    if (value == null) return defaultValue;
    return double.tryParse(value) ?? defaultValue;
  }

  // ============================================================================
  // TYPED SETTERS (Helper methods for common types)
  // ============================================================================

  Future<void> setBoolSetting(String key, bool value) async {
    await setSetting(key, value.toString());
  }

  Future<void> setIntSetting(String key, int value) async {
    await setSetting(key, value.toString());
  }

  Future<void> setDoubleSetting(String key, double value) async {
    await setSetting(key, value.toString());
  }

  // ============================================================================
  // RESET TO DEFAULTS (Clear all settings)
  // ============================================================================

  Future<void> resetToDefaults() async {
    await deleteAllSettings();
  }

  // ============================================================================
  // GET SETTINGS COUNT
  // ============================================================================

  Future<int> getSettingsCount() async {
    final countQuery = selectOnly(appSettings)
      ..addColumns([appSettings.id.count()]);
    final result = await countQuery.getSingle();
    return result.read(appSettings.id.count()) ?? 0;
  }

  // ============================================================================
  // GET LAST UPDATED TIMESTAMP
  // ============================================================================

  Future<DateTime?> getLastUpdated() async {
    final query = select(appSettings)
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.updatedAt)])
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.updatedAt;
  }
}
