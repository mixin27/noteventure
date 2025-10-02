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

  Challenge copyWith({
    String? id,
    ChallengeType? type,
    String? difficulty,
    String? question,
    String? correctAnswer,
    List<String>? options,
    int? pointReward,
    int? xpReward,
    int? timeLimit,
  }) {
    return Challenge(
      id: id ?? this.id,
      type: type ?? this.type,
      difficulty: difficulty ?? this.difficulty,
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      options: options ?? this.options,
      pointReward: pointReward ?? this.pointReward,
      xpReward: xpReward ?? this.xpReward,
      timeLimit: timeLimit ?? this.timeLimit,
    );
  }
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
