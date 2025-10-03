import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

import '../../domain/usecases/get_all_chievements.dart';
import '../../domain/usecases/get_unlocked_achivements.dart';
import '../../domain/usecases/initialize_achievement.dart';
import '../../domain/usecases/unlock_achievement.dart';
import '../../domain/usecases/update_achievement_progress.dart';
import '../../domain/usecases/watch_achievements.dart';
import 'achievements_event.dart';
import 'achievements_state.dart';

class AchievementsBloc extends Bloc<AchievementsEvent, AchievementsState> {
  final GetAllAchievements getAllAchievements;
  final GetUnlockedAchievements getUnlockedAchievements;
  final UpdateAchievementProgress updateAchievementProgress;
  final UnlockAchievement unlockAchievement;
  final InitializeAchievements initializeAchievements;
  final WatchAchievements watchAchievements;

  StreamSubscription? _achievementsSubscription;
  StreamSubscription? _eventBusSubscription;

  AchievementsBloc({
    required this.getAllAchievements,
    required this.getUnlockedAchievements,
    required this.updateAchievementProgress,
    required this.unlockAchievement,
    required this.initializeAchievements,
    required this.watchAchievements,
  }) : super(AchievementsInitial()) {
    on<LoadAchievements>(_onLoadAchievements);
    on<LoadUnlockedAchievements>(_onLoadUnlockedAchievements);
    on<UpdateAchievementProgressEvent>(_onUpdateProgress);
    on<UnlockAchievementEvent>(_onUnlockAchievement);
    on<InitializeAchievementsEvent>(_onInitializeAchievements);
    on<AchievementsUpdated>(_onAchievementsUpdated);

    // Watch achievements stream
    _achievementsSubscription = watchAchievements().listen((achievements) {
      if (!isClosed) {
        add(AchievementsUpdated(achievements));
      }
    });

    // Listen to EventBus for challenge/note/progress events
    _eventBusSubscription = AppEventBus().stream.listen((event) {
      if (event is ChallengeCompletedEvent) {
        _handleChallengeCompleted(event);
      } else if (event is NoteCreatedEvent) {
        _handleNoteCreated(event);
      } else if (event is NoteDeletedEvent) {
        _handleNoteDeleted(event);
      }
    });
  }

  @override
  Future<void> close() async {
    await _achievementsSubscription?.cancel();
    await _eventBusSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadAchievements(
    LoadAchievements event,
    Emitter<AchievementsState> emit,
  ) async {
    emit(AchievementsLoading());

    final result = await getAllAchievements();

    result.fold(
      (failure) => emit(AchievementsError(failure.message)),
      (achievements) => emit(AchievementsLoaded(achievements)),
    );
  }

  Future<void> _onLoadUnlockedAchievements(
    LoadUnlockedAchievements event,
    Emitter<AchievementsState> emit,
  ) async {
    emit(AchievementsLoading());

    final result = await getUnlockedAchievements();

    result.fold(
      (failure) => emit(AchievementsError(failure.message)),
      (achievements) => emit(AchievementsLoaded(achievements)),
    );
  }

  Future<void> _onUpdateProgress(
    UpdateAchievementProgressEvent event,
    Emitter<AchievementsState> emit,
  ) async {
    await updateAchievementProgress(event.achievementKey, event.progress);
  }

  Future<void> _onUnlockAchievement(
    UnlockAchievementEvent event,
    Emitter<AchievementsState> emit,
  ) async {
    final result = await unlockAchievement(event.achievementKey);

    result.fold(
      (failure) => emit(AchievementsError(failure.message)),
      (_) {}, // Will be handled by stream update
    );
  }

  Future<void> _onInitializeAchievements(
    InitializeAchievementsEvent event,
    Emitter<AchievementsState> emit,
  ) async {
    await initializeAchievements();
    add(LoadAchievements());
  }

  void _onAchievementsUpdated(
    AchievementsUpdated event,
    Emitter<AchievementsState> emit,
  ) {
    emit(AchievementsLoaded(event.achievements));
  }

  // Event handlers for achievement tracking
  void _handleChallengeCompleted(ChallengeCompletedEvent event) {
    if (event.wasCorrect) {
      // Update various challenge-related achievements
      _checkAndUpdateAchievement('first_challenge', 1);
      _checkAndUpdateAchievement('challenge_master', 1);
      _checkAndUpdateAchievement('speed_demon', 1); // Need to check time
    }
  }

  void _handleNoteCreated(NoteCreatedEvent event) {
    _checkAndUpdateAchievement('first_note', 1);
    _checkAndUpdateAchievement('note_hoarder', 1);
  }

  void _handleNoteDeleted(NoteDeletedEvent event) {
    _checkAndUpdateAchievement('deletion_king', 1);
  }

  Future<void> _checkAndUpdateAchievement(String key, int increment) async {
    // This would need proper implementation with current progress tracking
    // For now, just increment progress
    if (!isClosed) {
      add(UpdateAchievementProgressEvent(key, increment));
    }
  }
}
