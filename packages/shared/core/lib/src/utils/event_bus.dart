import 'dart:async';

/// Base class for all app events
abstract class AppEvent {
  final DateTime timestamp;

  AppEvent() : timestamp = DateTime.now();
}

/// Event bus for loose coupling between features
class AppEventBus {
  static final AppEventBus _instance = AppEventBus._internal();
  factory AppEventBus() => _instance;
  AppEventBus._internal();

  final StreamController<AppEvent> _controller =
      StreamController<AppEvent>.broadcast();

  /// Get event stream
  Stream<AppEvent> get stream => _controller.stream;

  /// Get typed event stream
  Stream<T> on<T extends AppEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  /// Emit an event
  void emit(AppEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  /// Dispose the event bus
  void dispose() {
    _controller.close();
  }
}

// ============================================================================
// Event Definitions
// ============================================================================

/// Points-related events
class PointsChangedEvent extends AppEvent {
  final int newBalance;
  final int change;
  final String reason;

  PointsChangedEvent({
    required this.newBalance,
    required this.change,
    required this.reason,
  });
}

class PointsSpentEvent extends AppEvent {
  final int amount;
  final String action;
  final int? relatedId;

  PointsSpentEvent({
    required this.amount,
    required this.action,
    this.relatedId,
  });
}

class PointsEarnedEvent extends AppEvent {
  final int amount;
  final String source;
  final int? relatedId;

  PointsEarnedEvent({
    required this.amount,
    required this.source,
    this.relatedId,
  });
}

/// Note-related events
class NoteCreatedEvent extends AppEvent {
  final int noteId;
  final String noteType;

  NoteCreatedEvent({required this.noteId, required this.noteType});
}

class NoteUpdatedEvent extends AppEvent {
  final int noteId;

  NoteUpdatedEvent(this.noteId);
}

class NoteDeletedEvent extends AppEvent {
  final int noteId;

  NoteDeletedEvent(this.noteId);
}

/// Challenge-related events
class ChallengeCompletedEvent extends AppEvent {
  final int challengeId;
  final bool wasCorrect;
  final int pointsEarned;
  final int xpEarned;
  final String challengeType;

  ChallengeCompletedEvent({
    required this.challengeId,
    required this.wasCorrect,
    required this.pointsEarned,
    required this.xpEarned,
    required this.challengeType,
  });
}

class ChallengeFailedEvent extends AppEvent {
  final int challengeId;
  final String challengeType;
  final int pointsLost;

  ChallengeFailedEvent({
    required this.challengeId,
    required this.challengeType,
    required this.pointsLost,
  });
}

class StreakUpdatedEvent extends AppEvent {
  final int currentStreak;
  final bool isNewRecord;

  StreakUpdatedEvent({required this.currentStreak, required this.isNewRecord});
}

/// Progress-related events
class XpGainedEvent extends AppEvent {
  final int amount;
  final String source;

  XpGainedEvent({required this.amount, required this.source});
}

class LevelUpEvent extends AppEvent {
  final int oldLevel;
  final int newLevel;
  final List<String> unlockedFeatures;

  LevelUpEvent({
    required this.oldLevel,
    required this.newLevel,
    this.unlockedFeatures = const [],
  });
}

/// Achievement-related events
class AchievementUnlockedEvent extends AppEvent {
  final String achievementKey;
  final String achievementName;
  final int pointReward;

  AchievementUnlockedEvent({
    required this.achievementKey,
    required this.achievementName,
    required this.pointReward,
  });
}

class AchievementProgressUpdatedEvent extends AppEvent {
  final String achievementKey;
  final int currentProgress;
  final int targetValue;

  AchievementProgressUpdatedEvent({
    required this.achievementKey,
    required this.currentProgress,
    required this.targetValue,
  });
}

/// Chaos-related events
class ChaosEventTriggeredEvent extends AppEvent {
  final String eventKey;
  final String eventType;
  final String title;
  final String message;

  ChaosEventTriggeredEvent({
    required this.eventKey,
    required this.eventType,
    required this.title,
    required this.message,
  });
}

class ChaosEffectAppliedEvent extends AppEvent {
  final String effectType;
  final double multiplier;
  final DateTime expiresAt;

  ChaosEffectAppliedEvent({
    required this.effectType,
    required this.multiplier,
    required this.expiresAt,
  });
}

class ChaosEffectExpiredEvent extends AppEvent {
  final String effectType;

  ChaosEffectExpiredEvent(this.effectType);
}

/// Theme-related events
class ThemeUnlockedEvent extends AppEvent {
  final String themeKey;
  final String themeName;

  ThemeUnlockedEvent({required this.themeKey, required this.themeName});
}

class ThemeChangedEvent extends AppEvent {
  final String themeKey;

  ThemeChangedEvent(this.themeKey);
}

/// App-wide events
class AppPausedEvent extends AppEvent {}

class AppResumedEvent extends AppEvent {}

class AppErrorEvent extends AppEvent {
  final String error;
  final StackTrace? stackTrace;

  AppErrorEvent({required this.error, this.stackTrace});
}
