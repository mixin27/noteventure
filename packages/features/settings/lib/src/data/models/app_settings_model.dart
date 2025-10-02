import '../../domain/entities/app_settings.dart';

class AppSettingsModel extends AppSettings {
  const AppSettingsModel({
    required super.soundEnabled,
    required super.notificationsEnabled,
    required super.chaosEnabled,
    required super.challengeTimeLimit,
    required super.personalityTone,
    required super.hapticFeedbackEnabled,
    required super.themeMode,
    required super.showTutorial,
    required super.profanityFilter,
  });

  factory AppSettingsModel.fromEntity(AppSettings entity) {
    return AppSettingsModel(
      soundEnabled: entity.soundEnabled,
      notificationsEnabled: entity.notificationsEnabled,
      chaosEnabled: entity.chaosEnabled,
      challengeTimeLimit: entity.challengeTimeLimit,
      personalityTone: entity.personalityTone,
      hapticFeedbackEnabled: entity.hapticFeedbackEnabled,
      themeMode: entity.themeMode,
      showTutorial: entity.showTutorial,
      profanityFilter: entity.profanityFilter,
    );
  }

  AppSettings toEntity() {
    return AppSettings(
      soundEnabled: soundEnabled,
      notificationsEnabled: notificationsEnabled,
      chaosEnabled: chaosEnabled,
      challengeTimeLimit: challengeTimeLimit,
      personalityTone: personalityTone,
      hapticFeedbackEnabled: hapticFeedbackEnabled,
      themeMode: themeMode,
      showTutorial: showTutorial,
      profanityFilter: profanityFilter,
    );
  }

  // Create from database rows
  factory AppSettingsModel.fromDatabase(Map<String, dynamic> settings) {
    return AppSettingsModel(
      soundEnabled: settings['sound_enabled'] as bool? ?? true,
      notificationsEnabled: settings['notifications_enabled'] as bool? ?? true,
      chaosEnabled: settings['chaos_enabled'] as bool? ?? true,
      challengeTimeLimit: settings['challenge_time_limit'] as int? ?? 30,
      personalityTone: settings['personality_tone'] as String? ?? 'random',
      hapticFeedbackEnabled:
          settings['haptic_feedback_enabled'] as bool? ?? true,
      themeMode: settings['theme_mode'] as String? ?? 'system',
      showTutorial: settings['show_tutorial'] as bool? ?? true,
      profanityFilter: settings['profanity_filter'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'sound_enabled': soundEnabled,
      'notifications_enabled': notificationsEnabled,
      'chaos_enabled': chaosEnabled,
      'challenge_time_limit': challengeTimeLimit,
      'personality_tone': personalityTone,
      'haptic_feedback_enabled': hapticFeedbackEnabled,
      'theme_mode': themeMode,
      'show_tutorial': showTutorial,
      'profanity_filter': profanityFilter,
    };
  }
}
