import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final bool soundEnabled;
  final bool notificationsEnabled;
  final bool chaosEnabled;
  final int challengeTimeLimit; // seconds (10-120)
  final String
  personalityTone; // random, sarcastic, wholesome, chaotic, deadpan
  final bool hapticFeedbackEnabled;
  final String themeMode; // light, dark, system
  final bool showTutorial;
  final bool profanityFilter;
  final DateTime? lastSyncTimestamp;

  const AppSettings({
    this.soundEnabled = true,
    this.notificationsEnabled = true,
    this.chaosEnabled = true,
    this.challengeTimeLimit = 30,
    this.personalityTone = 'random',
    this.hapticFeedbackEnabled = true,
    this.themeMode = 'system',
    this.showTutorial = true,
    this.profanityFilter = true,
    this.lastSyncTimestamp,
  });

  AppSettings copyWith({
    bool? soundEnabled,
    bool? notificationsEnabled,
    bool? chaosEnabled,
    int? challengeTimeLimit,
    String? personalityTone,
    bool? hapticFeedbackEnabled,
    String? themeMode,
    bool? showTutorial,
    bool? profanityFilter,
    DateTime? lastSyncTimestamp,
  }) {
    return AppSettings(
      soundEnabled: soundEnabled ?? this.soundEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      chaosEnabled: chaosEnabled ?? this.chaosEnabled,
      challengeTimeLimit: challengeTimeLimit ?? this.challengeTimeLimit,
      personalityTone: personalityTone ?? this.personalityTone,
      hapticFeedbackEnabled:
          hapticFeedbackEnabled ?? this.hapticFeedbackEnabled,
      themeMode: themeMode ?? this.themeMode,
      showTutorial: showTutorial ?? this.showTutorial,
      profanityFilter: profanityFilter ?? this.profanityFilter,
      lastSyncTimestamp: lastSyncTimestamp ?? this.lastSyncTimestamp,
    );
  }

  @override
  List<Object?> get props => [
    soundEnabled,
    notificationsEnabled,
    chaosEnabled,
    challengeTimeLimit,
    personalityTone,
    hapticFeedbackEnabled,
    themeMode,
    showTutorial,
    profanityFilter,
    lastSyncTimestamp,
  ];
}
