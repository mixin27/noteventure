import 'package:equatable/equatable.dart';

class Achievement extends Equatable {
  final int id;
  final String achievementKey;
  final String name;
  final String description;
  final String iconName;
  final int targetValue;
  final int currentProgress;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final int pointReward;
  final AchievementRarity rarity;

  const Achievement({
    required this.id,
    required this.achievementKey,
    required this.name,
    required this.description,
    required this.iconName,
    required this.targetValue,
    required this.currentProgress,
    required this.isUnlocked,
    this.unlockedAt,
    required this.pointReward,
    required this.rarity,
  });

  double get progressPercentage {
    if (targetValue == 0) return 0;
    return (currentProgress / targetValue * 100).clamp(0, 100);
  }

  bool get isCompleted => currentProgress >= targetValue;

  Achievement copyWith({
    int? id,
    String? achievementKey,
    String? name,
    String? description,
    String? iconName,
    int? targetValue,
    int? currentProgress,
    bool? isUnlocked,
    DateTime? unlockedAt,
    int? pointReward,
    AchievementRarity? rarity,
  }) {
    return Achievement(
      id: id ?? this.id,
      achievementKey: achievementKey ?? this.achievementKey,
      name: name ?? this.name,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
      targetValue: targetValue ?? this.targetValue,
      currentProgress: currentProgress ?? this.currentProgress,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      pointReward: pointReward ?? this.pointReward,
      rarity: rarity ?? this.rarity,
    );
  }

  @override
  List<Object?> get props => [
    id,
    achievementKey,
    name,
    description,
    iconName,
    targetValue,
    currentProgress,
    isUnlocked,
    unlockedAt,
    pointReward,
    rarity,
  ];
}

enum AchievementRarity {
  common,
  rare,
  epic,
  legendary;

  String get displayName => switch (this) {
    AchievementRarity.common => 'Common',
    AchievementRarity.rare => 'Rare',
    AchievementRarity.epic => 'Epic',
    AchievementRarity.legendary => 'Legendary',
  };

  static AchievementRarity fromString(String value) {
    return AchievementRarity.values.firstWhere(
      (type) => type.name == value,
      orElse: () => AchievementRarity.common,
    );
  }
}
