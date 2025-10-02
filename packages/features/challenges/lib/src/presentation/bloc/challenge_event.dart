import 'package:equatable/equatable.dart';

import '../../domain/entities/challenge.dart';

sealed class ChallengeEvent extends Equatable {
  const ChallengeEvent();

  @override
  List<Object?> get props => [];
}

final class GenerateNewChallenge extends ChallengeEvent {
  final ChallengeType? type;
  final String? difficulty;

  const GenerateNewChallenge({this.type, this.difficulty});

  @override
  List<Object?> get props => [type, difficulty];
}

final class SubmitChallengeAnswer extends ChallengeEvent {
  final String answer;

  const SubmitChallengeAnswer(this.answer);

  @override
  List<Object?> get props => [answer];
}

final class UpdateTimeLimit extends ChallengeEvent {
  final int timeLimit;

  const UpdateTimeLimit(this.timeLimit);

  @override
  List<Object?> get props => [timeLimit];
}

final class ResetChallenge extends ChallengeEvent {}
