import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:points/points.dart';

import '../../domain/usecases/generate_challenge.dart';
import '../../domain/usecases/submit_answer.dart';
import 'challenge_event.dart';
import 'challenge_state.dart';

class ChallengeBloc extends Bloc<ChallengeEvent, ChallengeState> {
  final GenerateChallenge generateChallenge;
  final SubmitAnswer submitAnswer;
  final PointsBloc pointsBloc;

  ChallengeBloc({
    required this.generateChallenge,
    required this.submitAnswer,
    required this.pointsBloc,
  }) : super(ChallengeInitial()) {
    on<GenerateNewChallenge>(_onGenerateNewChallenge);
    on<SubmitChallengeAnswer>(_onSubmitChallengeAnswer);
    on<ResetChallenge>(_onResetChallenge);
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

    result.fold(
      (failure) => emit(ChallengeError(failure.message)),
      (challenge) =>
          emit(ChallengeReady(challenge: challenge, startTime: DateTime.now())),
    );
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
}
