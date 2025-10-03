import 'package:equatable/equatable.dart';

import '../../domain/entities/achievement.dart';

sealed class AchievementsState extends Equatable {
  const AchievementsState();

  @override
  List<Object?> get props => [];
}

final class AchievementsInitial extends AchievementsState {}

final class AchievementsLoading extends AchievementsState {}

final class AchievementsLoaded extends AchievementsState {
  final List<Achievement> achievements;

  const AchievementsLoaded(this.achievements);

  int get totalAchievements => achievements.length;
  int get unlockedCount => achievements.where((a) => a.isUnlocked).length;
  double get completionPercentage {
    if (totalAchievements == 0) return 0;
    return (unlockedCount / totalAchievements * 100);
  }

  List<Achievement> get unlocked =>
      achievements.where((a) => a.isUnlocked).toList();
  List<Achievement> get locked =>
      achievements.where((a) => !a.isUnlocked).toList();

  @override
  List<Object?> get props => [achievements];
}

final class AchievementsError extends AchievementsState {
  final String message;

  const AchievementsError(this.message);

  @override
  List<Object?> get props => [message];
}

final class AchievementUnlocked extends AchievementsState {
  final Achievement achievement;
  final List<Achievement> allAchievements;

  const AchievementUnlocked(this.achievement, this.allAchievements);

  @override
  List<Object?> get props => [achievement, allAchievements];
}
