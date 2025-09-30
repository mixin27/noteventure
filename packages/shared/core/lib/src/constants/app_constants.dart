class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // App Info
  static const String appName = 'Noteventure';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'noteventure.db';
  static const int databaseVersion = 1;

  // Starting Values
  static const int startingPoints = 100;
  static const int startingLevel = 1;
  static const int startingXp = 0;

  // Challenge Timing
  static const int defaultChallengeTimeLimit = 30; // seconds
  static const int minChallengeTimeLimit = 10;
  static const int maxChallengeTimeLimit = 120;

  // Chaos System
  static const int chaosEventMinActions = 5;
  static const int chaosEventMaxActions = 15;
  static const double chaosEventTimeProbability = 0.1; // 10% chance per minute

  // Streaks
  static const int streakBonusPoints = 5;
  static const int streakBonusXp = 10;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // API (for future use)
  static const String apiBaseUrl = 'https://api.noteventure.app';
  static const Duration apiTimeout = Duration(seconds: 30);

  // Audio
  static const double defaultVolume = 0.7;
  static const bool soundEnabledByDefault = true;
}
