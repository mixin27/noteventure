/// Constants for setting keys to avoid typos and ensure consistency
class SettingKeys {
  // Audio & Feedback
  static const String soundEnabled = 'sound_enabled';
  static const String hapticFeedbackEnabled = 'haptic_feedback_enabled';
  static const String notificationsEnabled = 'notifications_enabled';

  // Gameplay
  static const String chaosEnabled = 'chaos_enabled';

  // Appearance
  static const String themeMode = 'theme_mode';

  // Challenge
  static const String challengeTimeLimit = 'challenge_time_limit';
  static const String personalityTone = 'personality_tone';

  // Content
  static const String profanityFilter = 'profanity_filter';

  // Tutorial
  static const String showTutorial = 'show_tutorial';

  // Private constructor to prevent instantiation
  SettingKeys._();
}

/// Constants for common setting values
class SettingValues {
  // Theme modes
  static const String themeModeLight = 'light';
  static const String themeModeDark = 'dark';
  static const String themeModeSystem = 'system';

  // Personality tones
  static const String personalityRandom = 'random';
  static const String personalitySarcastic = 'sarcastic';
  static const String personalityWholesome = 'wholesome';
  static const String personalityChaotic = 'chaotic';
  static const String personalityDeadpan = 'deadpan';

  // Boolean values
  static const String boolTrue = 'true';
  static const String boolFalse = 'false';

  // Private constructor to prevent instantiation
  SettingValues._();
}
