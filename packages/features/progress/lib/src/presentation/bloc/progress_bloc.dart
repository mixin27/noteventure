import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

import '../../domain/repositories/progress_repository.dart';
import '../../domain/usecases/add_xp.dart';
import '../../domain/usecases/get_user_progress.dart';
import '../../domain/usecases/update_streak.dart';
import 'progress_event.dart';
import 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final GetUserProgress getUserProgress;
  final AddXp addXp;
  final UpdateStreak updateStreak;
  final ProgressRepository repository;

  StreamSubscription? _eventBusSubscription;

  ProgressBloc({
    required this.getUserProgress,
    required this.addXp,
    required this.updateStreak,
    required this.repository,
  }) : super(ProgressInitial()) {
    on<LoadUserProgress>(_onLoadUserProgress);
    on<AddXpEvent>(_onAddXp);
    on<UpdateStreakEvent>(_onUpdateStreak);

    // Listen to EventBus for automatic updates
    _listenToEvents();
  }

  void _listenToEvents() {
    _eventBusSubscription = AppEventBus().stream.listen((event) {
      if (event is ChallengeCompletedEvent && event.wasCorrect) {
        // Add XP
        if (!isClosed) {
          add(AddXpEvent(event.xpEarned));
        }

        // Update stats (these should NOT reload progress)
        repository.incrementChallengesSolved();
        repository.updateStreak(true);
      } else if (event is ChallengeFailedEvent) {
        repository.incrementChallengesFailed();
        repository.updateStreak(false);
        // add(LoadUserProgress());
      } else if (event is NoteCreatedEvent) {
        repository.incrementNotesCreated();
        // add(LoadUserProgress());
      } else if (event is NoteDeletedEvent) {
        repository.incrementNotesDeleted();
        // add(LoadUserProgress());
      }
    });
  }

  @override
  Future<void> close() {
    _eventBusSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadUserProgress(
    LoadUserProgress event,
    Emitter<ProgressState> emit,
  ) async {
    emit(ProgressLoading());

    final result = await getUserProgress();

    result.fold(
      (failure) => emit(ProgressError(failure.message)),
      (progress) => emit(ProgressLoaded(progress)),
    );
  }

  Future<void> _onAddXp(AddXpEvent event, Emitter<ProgressState> emit) async {
    final result = await addXp(event.amount);

    result.fold((failure) => emit(ProgressError(failure.message)), (
      levelUpResult,
    ) async {
      // Get updated progress
      final progressResult = await getUserProgress();

      progressResult.fold((failure) => emit(ProgressError(failure.message)), (
        progress,
      ) {
        if (levelUpResult['leveledUp'] == true) {
          AudioManager().playLevelUp();

          emit(
            ProgressLeveledUp(
              oldLevel: levelUpResult['oldLevel'],
              newLevel: levelUpResult['newLevel'],
              progress: progress,
            ),
          );
        } else {
          emit(ProgressLoaded(progress));
        }
      });
    });
  }

  Future<void> _onUpdateStreak(
    UpdateStreakEvent event,
    Emitter<ProgressState> emit,
  ) async {
    final result = await updateStreak(event.success);

    result.fold(
      (failure) => emit(ProgressError(failure.message)),
      (progress) => emit(ProgressLoaded(progress)),
    );
  }
}
