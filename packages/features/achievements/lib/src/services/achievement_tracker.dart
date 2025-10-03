import 'dart:async';

import 'package:core/core.dart';

import '../domain/usecases/update_achievement_progress.dart';

class AchievementTracker {
  final UpdateAchievementProgress updateProgress;
  StreamSubscription? _eventBusSubscription;

  AchievementTracker(this.updateProgress) {
    _startListening();
  }

  void _startListening() {
    _eventBusSubscription = AppEventBus().stream.listen((event) {
      if (event is ChallengeCompletedEvent) {
        _onChallengeCompleted(event);
      } else if (event is NoteCreatedEvent) {
        _onNoteCreated(event);
      } else if (event is NoteDeletedEvent) {
        _onNoteDeleted(event);
      } else if (event is LevelUpEvent) {
        _onLevelUp(event);
      }
    });
  }

  Future<void> _onChallengeCompleted(ChallengeCompletedEvent event) async {
    if (event.wasCorrect) {
      await updateProgress('first_challenge', 1);
      await updateProgress('challenge_master', 1);

      // Check for speed demon (if time tracking available)
      // await updateProgress('speed_demon', 1);
    }
  }

  Future<void> _onNoteCreated(NoteCreatedEvent event) async {
    await updateProgress('first_note', 1);
    await updateProgress('note_hoarder', 1);
  }

  Future<void> _onNoteDeleted(NoteDeletedEvent event) async {
    await updateProgress('deletion_king', 1);
  }

  Future<void> _onLevelUp(LevelUpEvent event) async {
    if (event.newLevel == 10) {
      await updateProgress('level_10', 1);
    } else if (event.newLevel == 50) {
      await updateProgress('level_50', 1);
    }
  }

  void dispose() {
    _eventBusSubscription?.cancel();
  }
}
