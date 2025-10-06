import 'dart:async';
import 'dart:math';
import 'package:core/core.dart';
import 'package:flutter/rendering.dart';

import '../presentation/bloc/chaos_bloc.dart';
import '../presentation/bloc/chaos_event.dart';

class ChaosTriggerService {
  final ChaosBloc _chaosBloc;
  final Random _random = Random();

  StreamSubscription? _actionSubscription;

  int _actionCount = 0;
  DateTime? _lastChaosCheck;

  // Configuration
  static const int actionsBeforeChaosCheck = 5;
  static const double chaosChancePercentage = 15.0;
  static const double timeChaosChancePercentage = 5.0;
  static const Duration timeChaosInterval = Duration(minutes: 10);

  // Track which actions count towards chaos
  static const Set<Type> _chaosTriggeredEvents = {
    NoteCreatedEvent,
    NoteUpdatedEvent,
    NoteDeletedEvent,
    ChallengeCompletedEvent,
    ChallengeFailedEvent,
    PointsSpentEvent,
    ThemeChangedEvent,
    AchievementUnlockedEvent,
  };

  ChaosTriggerService(this._chaosBloc) {
    _startListening();
  }

  void _startListening() {
    debugPrint("Listening chaos trigger service....");
    // Listen to all app events
    _actionSubscription = AppEventBus().stream.listen((event) {
      if (_shouldTriggerChaos(event)) {
        _handleAction(event);
      }
    });
  }

  bool _shouldTriggerChaos(AppEvent event) {
    debugPrint("Trigger event: ${event.runtimeType}");
    return _chaosTriggeredEvents.contains(event.runtimeType);
  }

  void _handleAction(AppEvent event) {
    _actionCount++;

    // Check action-based chaos
    if (_actionCount >= actionsBeforeChaosCheck) {
      _evaluateActionChaos();
      _actionCount = 0;
    }

    // Check time-based chaos
    _evaluateTimeChaos();
  }

  void _evaluateActionChaos() {
    final chance = _random.nextDouble() * 100;

    if (chance <= chaosChancePercentage) {
      _triggerChaos('action_based');
    }
  }

  void _evaluateTimeChaos() {
    final now = DateTime.now();

    if (_lastChaosCheck == null ||
        now.difference(_lastChaosCheck!) > timeChaosInterval) {
      _lastChaosCheck = now;

      final chance = _random.nextDouble() * 100;

      if (chance <= timeChaosChancePercentage) {
        _triggerChaos('time_based');
      }
    }
  }

  void _triggerChaos(String source) {
    debugPrint("Trigger chaos for $source");
    _chaosBloc.add(TriggerRandomEventAction());
  }

  void reset() {
    _actionCount = 0;
    _lastChaosCheck = null;
  }

  void dispose() {
    debugPrint("Listening chaos trigger service is cancelled");
    _actionSubscription?.cancel();
  }
}
