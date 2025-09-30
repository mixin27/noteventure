import 'dart:math';

/// Utility class for calculating XP and levels
class XpCalculator {
  // Prevent instantiation
  XpCalculator._();

  // Base XP required for level 2
  static const int baseXpForLevel2 = 100;

  // Multiplier for XP curve
  static const double xpCurveMultiplier = 1.5;

  /// Calculate XP required to reach a specific level
  static int xpRequiredForLevel(int level) {
    if (level <= 1) return 0;

    // Formula: baseXP * (level - 1)^1.5
    // Level 2: 100
    // Level 3: ~212
    // Level 4: ~360
    // Level 5: ~550
    // etc.
    return (baseXpForLevel2 * pow(level - 1, xpCurveMultiplier)).round();
  }

  /// Calculate total XP needed from level 1 to target level
  static int totalXpForLevel(int level) {
    if (level <= 1) return 0;

    var total = 0;
    for (var i = 2; i <= level; i++) {
      total += xpRequiredForLevel(i);
    }
    return total;
  }

  /// Calculate current level based on total XP
  static int calculateLevel(int totalXp) {
    if (totalXp < baseXpForLevel2) return 1;

    var level = 1;
    var xpAccumulated = 0;

    while (xpAccumulated <= totalXp) {
      level++;
      xpAccumulated += xpRequiredForLevel(level);
    }

    return level - 1; // Return the last completed level
  }

  /// Calculate XP progress in current level
  /// Returns a map with current XP, required XP, and progress percentage
  static Map<String, dynamic> calculateProgress(int totalXp) {
    final currentLevel = calculateLevel(totalXp);
    final xpForCurrentLevel = totalXpForLevel(currentLevel);
    final xpForNextLevel = totalXpForLevel(currentLevel + 1);
    final xpInCurrentLevel = totalXp - xpForCurrentLevel;
    final xpNeededForNextLevel = xpForNextLevel - xpForCurrentLevel;
    final progressPercentage = (xpInCurrentLevel / xpNeededForNextLevel * 100)
        .clamp(0, 100);

    return {
      'currentLevel': currentLevel,
      'currentXp': xpInCurrentLevel,
      'xpToNextLevel': xpNeededForNextLevel,
      'xpRemaining': xpNeededForNextLevel - xpInCurrentLevel,
      'progressPercentage': progressPercentage,
      'totalXp': totalXp,
    };
  }

  /// Check if XP gain will result in level up
  static bool willLevelUp(int currentTotalXp, int xpGain) {
    final currentLevel = calculateLevel(currentTotalXp);
    final newLevel = calculateLevel(currentTotalXp + xpGain);
    return newLevel > currentLevel;
  }

  /// Calculate how many levels will be gained
  static int levelsGained(int currentTotalXp, int xpGain) {
    final currentLevel = calculateLevel(currentTotalXp);
    final newLevel = calculateLevel(currentTotalXp + xpGain);
    return max(0, newLevel - currentLevel);
  }

  /// Calculate XP needed to reach next level
  static int xpToNextLevel(int currentTotalXp) {
    final currentLevel = calculateLevel(currentTotalXp);
    // final xpForCurrentLevel = totalXpForLevel(currentLevel);
    final xpForNextLevel = totalXpForLevel(currentLevel + 1);
    return xpForNextLevel - currentTotalXp;
  }

  /// Calculate bonus XP for streak
  static int calculateStreakBonus(int streakCount) {
    // Give bonus XP for every 5 challenges in a streak
    final bonusMultiplier = (streakCount / 5).floor();
    return bonusMultiplier * 10; // 10 XP per 5-streak milestone
  }

  /// Calculate XP multiplier based on difficulty
  static double getDifficultyMultiplier(String difficulty) {
    return switch (difficulty) {
      'easy' => 1.0,
      'medium' => 1.5,
      'hard' => 2.0,
      _ => 1.0,
    };
  }
}
