import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:points/points.dart';
import 'package:settings/settings.dart';

import '../../domain/usecases/generate_challenge.dart';
import '../../domain/usecases/submit_answer.dart';
import 'challenge_event.dart';
import 'challenge_state.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  final GenerateChallenge generateChallenge;
  final SubmitAnswer submitAnswer;
  final PointsBloc pointsBloc;

  final WatchSettings watchSettings;
  StreamSubscription? _settingsSubscription;
  int _currentTimeLimit = 30;

  ChallengeBloc({
    required this.generateChallenge,
    required this.submitAnswer,
    required this.pointsBloc,
    required this.watchSettings,
  }) : super(ChallengeInitial()) {
    on<GenerateNewChallenge>(_onGenerateNewChallenge);
    on<SubmitChallengeAnswer>(_onSubmitChallengeAnswer);
    on<ResetChallenge>(_onResetChallenge);
    on<UpdateTimeLimit>(_onUpdateTimeLimit);

    // Subscribe to settings stream directly - NO EventBus!
    _settingsSubscription = watchSettings().listen((settings) {
      _currentTimeLimit = settings.challengeTimeLimit;

      if (!isClosed) {
        add(UpdateTimeLimit(_currentTimeLimit));
      }
    });
  }

  @override
  Future<void> close() async {
    // Cancel subscription BEFORE calling super.close()
    await _settingsSubscription?.cancel();
    return super.close();
  }

  Future<void> _onGenerateNewChallenge(
    GenerateNewChallenge event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ChallengeLoading());

    final params = GenerateChallengeParams(
      type: event.type,
      difficulty: event.difficulty ?? 'easy',
    );

    final result = await generateChallenge(params);

    result.fold((failure) => emit(ChallengeError(failure.message)), (
      challenge,
    ) {
      emit(
        ChallengeReady(
          challenge: challenge.copyWith(timeLimit: _currentTimeLimit),
          startTime: DateTime.now(),
        ),
      );
    });
  }

  Future<void> _onSubmitChallengeAnswer(
    SubmitChallengeAnswer event,
    Emitter<ChallengeState> emit,
  ) async {
    if (state is! ChallengeReady) return;

    final currentState = state as ChallengeReady;
    final challenge = currentState.challenge;

    final params = SubmitAnswerParams(
      challenge: challenge,
      userAnswer: event.answer,
    );

    final result = submitAnswer(params);

    result.fold((failure) => emit(ChallengeError(failure.message)), (
      isCorrect,
    ) {
      if (isCorrect) {
        // Award points
        pointsBloc.add(
          EarnPointsEvent(
            amount: challenge.pointReward,
            reason: 'challenge_completed',
            description: 'Completed ${challenge.type.displayName} challenge',
          ),
        );

        // Generate fun message
        final message = MessageGenerator.getCorrectMessage('random');

        emit(
          ChallengeCorrect(
            challenge: challenge,
            pointsEarned: challenge.pointReward,
            xpEarned: challenge.xpReward,
            message: message,
          ),
        );

        // Emit event via EventBus
        AppEventBus().emit(
          ChallengeCompletedEvent(
            challengeId: 0, // todo(mixin27): Add proper ID
            wasCorrect: true,
            pointsEarned: challenge.pointReward,
            xpEarned: challenge.xpReward,
            challengeType: challenge.type.name,
          ),
        );

        AppEventBus().emit(
          XpGainedEvent(
            amount: challenge.xpReward,
            source: 'challenge_completed',
          ),
        );
      } else {
        final message = MessageGenerator.getWrongMessage('random');

        emit(
          ChallengeIncorrect(
            challenge: challenge,
            userAnswer: event.answer,
            correctAnswer: challenge.correctAnswer,
            message: message,
          ),
        );

        // Emit event via EventBus
        AppEventBus().emit(
          ChallengeFailedEvent(
            challengeId: 0, // todo(mixin27): Add proper ID
            challengeType: challenge.type.name,
            pointsLost: 0,
          ),
        );
      }
    });
  }

  Future<void> _onResetChallenge(
    ResetChallenge event,
    Emitter<ChallengeState> emit,
  ) async {
    emit(ChallengeInitial());
  }

  Future<void> _onUpdateTimeLimit(
    UpdateTimeLimit event,
    Emitter<ChallengeState> emit,
  ) async {
    // Update internal time limit
    _currentTimeLimit = event.timeLimit;

    // If there's an active challenge, optionally update it
    if (state is ChallengeReady) {
      final currentState = state as ChallengeReady;
      emit(
        ChallengeReady(
          challenge: currentState.challenge.copyWith(
            timeLimit: _currentTimeLimit,
          ),
          startTime: currentState.startTime,
        ),
      );
    }
  }
}
