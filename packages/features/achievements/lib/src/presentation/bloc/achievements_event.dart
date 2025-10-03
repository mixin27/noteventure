import 'package:equatable/equatable.dart';

import '../../domain/entities/achievement.dart';

sealed class AchievementsEvent extends Equatable {
  const AchievementsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAchievements extends AchievementsEvent {}

class LoadUnlockedAchievements extends AchievementsEvent {}

class LoadLockedAchievements extends AchievementsEvent {}

class UpdateAchievementProgressEvent extends AchievementsEvent {
  final String achievementKey;
  final int progress;

  const UpdateAchievementProgressEvent(this.achievementKey, this.progress);

  @override
  List<Object?> get props => [achievementKey, progress];
}

final class UnlockAchievementEvent extends AchievementsEvent {
  final String achievementKey;

  const UnlockAchievementEvent(this.achievementKey);

  @override
  List<Object?> get props => [achievementKey];
}

final class InitializeAchievementsEvent extends AchievementsEvent {}

final class AchievementsUpdated extends AchievementsEvent {
  final List<Achievement> achievements;

  const AchievementsUpdated(this.achievements);

  @override
  List<Object?> get props => [achievements];
}
