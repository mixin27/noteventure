import 'package:database/database.dart' as db;

import '../../domain/entities/achievement.dart';

class AchievementModel extends Achievement {
  const AchievementModel({
    required super.id,
    required super.achievementKey,
    required super.name,
    required super.description,
    required super.iconName,
    required super.targetValue,
    required super.currentProgress,
    required super.isUnlocked,
    super.unlockedAt,
    required super.pointReward,
    required super.rarity,
  });

  factory AchievementModel.fromEntity(Achievement entity) {
    return AchievementModel(
      id: entity.id,
      achievementKey: entity.achievementKey,
      name: entity.name,
      description: entity.description,
      iconName: entity.iconName,
      targetValue: entity.targetValue,
      currentProgress: entity.currentProgress,
      isUnlocked: entity.isUnlocked,
      unlockedAt: entity.unlockedAt,
      pointReward: entity.pointReward,
      rarity: entity.rarity,
    );
  }

  factory AchievementModel.fromDrift(db.Achievement data) {
    return AchievementModel(
      id: data.id,
      achievementKey: data.achievementKey,
      name: data.name,
      description: data.description,
      iconName: data.iconName,
      targetValue: data.targetValue,
      currentProgress: data.currentProgress,
      isUnlocked: data.isUnlocked,
      unlockedAt: data.unlockedAt,
      pointReward: data.pointReward,
      rarity: AchievementRarity.fromString(data.rarity),
    );
  }

  Achievement toEntity() {
    return Achievement(
      id: id,
      achievementKey: achievementKey,
      name: name,
      description: description,
      iconName: iconName,
      targetValue: targetValue,
      currentProgress: currentProgress,
      isUnlocked: isUnlocked,
      unlockedAt: unlockedAt,
      pointReward: pointReward,
      rarity: rarity,
    );
  }
}
