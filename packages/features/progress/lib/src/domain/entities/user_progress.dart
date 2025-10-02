import 'package:equatable/equatable.dart';

class UserProgress extends Equatable {
  final int level;
  final int currentXp;
  final int xpToNextLevel;
  final int totalXp;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastChallengeDate;
  final int totalChallengesSolved;
  final int totalChallengesFailed;
  final int totalNotesCreated;
  final int totalNotesDeleted;

  const UserProgress({
    required this.level,
    required this.currentXp,
    required this.xpToNextLevel,
    required this.totalXp,
    required this.currentStreak,
    required this.longestStreak,
    this.lastChallengeDate,
    required this.totalChallengesSolved,
    required this.totalChallengesFailed,
    required this.totalNotesCreated,
    required this.totalNotesDeleted,
  });

  double get progressPercentage {
    if (xpToNextLevel == 0) return 0;
    return (currentXp / xpToNextLevel * 100).clamp(0, 100);
  }

  int get totalChallenges => totalChallengesSolved + totalChallengesFailed;

  double get challengeAccuracy {
    if (totalChallenges == 0) return 0;
    return (totalChallengesSolved / totalChallenges * 100);
  }

  @override
  List<Object?> get props => [
    level,
    currentXp,
    xpToNextLevel,
    totalXp,
    currentStreak,
    longestStreak,
    lastChallengeDate,
    totalChallengesSolved,
    totalChallengesFailed,
    totalNotesCreated,
    totalNotesDeleted,
  ];
}
