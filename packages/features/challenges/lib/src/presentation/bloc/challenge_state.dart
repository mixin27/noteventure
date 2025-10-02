import 'package:equatable/equatable.dart';

import '../../domain/entities/challenge.dart';

sealed class ChallengeState extends Equatable {
  const ChallengeState();

  @override
  List<Object?> get props => [];
}

final class ChallengeInitial extends ChallengeState {}

final class ChallengeLoading extends ChallengeState {}

final class ChallengeReady extends ChallengeState {
  final Challenge challenge;
  final DateTime startTime;

  const ChallengeReady({required this.challenge, required this.startTime});

  @override
  List<Object?> get props => [challenge, startTime];
}

final class ChallengeCorrect extends ChallengeState {
  final Challenge challenge;
  final int pointsEarned;
  final int xpEarned;
  final String message;

  const ChallengeCorrect({
    required this.challenge,
    required this.pointsEarned,
    required this.xpEarned,
    required this.message,
  });

  @override
  List<Object?> get props => [challenge, pointsEarned, xpEarned, message];
}

final class ChallengeIncorrect extends ChallengeState {
  final Challenge challenge;
  final String userAnswer;
  final String correctAnswer;
  final String message;

  const ChallengeIncorrect({
    required this.challenge,
    required this.userAnswer,
    required this.correctAnswer,
    required this.message,
  });

  @override
  List<Object?> get props => [challenge, userAnswer, correctAnswer, message];
}

final class ChallengeError extends ChallengeState {
  final String message;

  const ChallengeError(this.message);

  @override
  List<Object?> get props => [message];
}
