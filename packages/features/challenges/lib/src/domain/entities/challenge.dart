import 'package:equatable/equatable.dart';

class Challenge extends Equatable {
  final String id;
  final ChallengeType type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String>? options; // For multiple choice
  final int pointReward;
  final int xpReward;
  final int timeLimit; // in seconds

  const Challenge({
    required this.id,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    this.options,
    required this.pointReward,
    required this.xpReward,
    required this.timeLimit,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    difficulty,
    question,
    correctAnswer,
    options,
    pointReward,
    xpReward,
    timeLimit,
  ];
}

enum ChallengeType {
  math,
  trivia,
  wordGame,
  pattern;

  String get displayName => switch (this) {
    ChallengeType.math => 'Math',
    ChallengeType.trivia => 'Trivia',
    ChallengeType.wordGame => 'Word Game',
    ChallengeType.pattern => 'Pattern',
  };
}
