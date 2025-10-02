import 'package:database/database.dart';

import '../models/app_settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<AppSettingsModel> getSettings();
  Future<void> updateSettings(AppSettingsModel settings);
  Future<void> resetSettings();
  Stream<AppSettingsModel> watchSettings();
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final AppSettingsDao appSettingsDao;

  SettingsLocalDataSourceImpl(this.appSettingsDao);

  @override
  Future<AppSettingsModel> getSettings() async {
    // Get all settings as a map
    final settingsMap = await appSettingsDao.getAllSettings();

    // If no settings exist, return defaults
    if (settingsMap.isEmpty) {
      final defaultSettings = const AppSettingsModel(
        soundEnabled: true,
        notificationsEnabled: true,
        chaosEnabled: true,
        challengeTimeLimit: 30,
        personalityTone: 'random',
        hapticFeedbackEnabled: true,
        themeMode: 'system',
        showTutorial: true,
        profanityFilter: true,
      );

      // Save defaults to database
      await updateSettings(defaultSettings);
      return defaultSettings;
    }

    // Parse settings map to typed values
    return AppSettingsModel.fromDatabase({
      'sound_enabled': _parseBool(settingsMap['sound_enabled'], true),
      'notifications_enabled': _parseBool(
        settingsMap['notifications_enabled'],
        true,
      ),
      'chaos_enabled': _parseBool(settingsMap['chaos_enabled'], true),
      'challenge_time_limit': _parseInt(
        settingsMap['challenge_time_limit'],
        30,
      ),
      'personality_tone': settingsMap['personality_tone'] ?? 'random',
      'haptic_feedback_enabled': _parseBool(
        settingsMap['haptic_feedback_enabled'],
        true,
      ),
      'theme_mode': settingsMap['theme_mode'] ?? 'system',
      'show_tutorial': _parseBool(settingsMap['show_tutorial'], true),
      'profanity_filter': _parseBool(settingsMap['profanity_filter'], true),
    });
  }

  @override
  Future<void> updateSettings(AppSettingsModel settings) async {
    final settingsMap = settings.toDatabase();

    // Use DAO's transaction method for atomic updates
    await appSettingsDao.setMultipleSettings(
      settingsMap.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  @override
  Future<void> resetSettings() async {
    await appSettingsDao.resetToDefaults();
  }

  @override
  Stream<AppSettingsModel> watchSettings() {
    return appSettingsDao.watchAllSettings().map((settingsMap) {
      // Parse settings map to typed values
      return AppSettingsModel.fromDatabase({
        'sound_enabled': _parseBool(settingsMap['sound_enabled'], true),
        'notifications_enabled': _parseBool(
          settingsMap['notifications_enabled'],
          true,
        ),
        'chaos_enabled': _parseBool(settingsMap['chaos_enabled'], true),
        'challenge_time_limit': _parseInt(
          settingsMap['challenge_time_limit'],
          30,
        ),
        'personality_tone': settingsMap['personality_tone'] ?? 'random',
        'haptic_feedback_enabled': _parseBool(
          settingsMap['haptic_feedback_enabled'],
          true,
        ),
        'theme_mode': settingsMap['theme_mode'] ?? 'system',
        'show_tutorial': _parseBool(settingsMap['show_tutorial'], true),
        'profanity_filter': _parseBool(settingsMap['profanity_filter'], true),
      });
    });
  }

  // Helper parsing methods
  bool _parseBool(String? value, bool defaultValue) {
    if (value == null) return defaultValue;
    return value.toLowerCase() == 'true';
  }

  int _parseInt(String? value, int defaultValue) {
    if (value == null) return defaultValue;
    return int.tryParse(value) ?? defaultValue;
  }
}
