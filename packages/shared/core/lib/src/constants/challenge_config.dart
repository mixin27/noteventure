class ChallengeConfig {
  // Prevent instantiation
  ChallengeConfig._();

  // Difficulty Levels
  static const String difficultyEasy = 'easy';
  static const String difficultyMedium = 'medium';
  static const String difficultyHard = 'hard';

  // Point Rewards by Difficulty (base values)
  static const Map<String, int> basePointRewards = {
    difficultyEasy: 10,
    difficultyMedium: 20,
    difficultyHard: 35,
  };

  // XP Rewards by Difficulty (base values)
  static const Map<String, int> baseXpRewards = {
    difficultyEasy: 15,
    difficultyMedium: 30,
    difficultyHard: 50,
  };

  // Time Limits by Difficulty (seconds)
  static const Map<String, int> timeLimits = {
    difficultyEasy: 30,
    difficultyMedium: 45,
    difficultyHard: 60,
  };

  // Challenge Types
  static const String typeMath = 'math';
  static const String typeTrivia = 'trivia';
  static const String typeWordGame = 'word_game';
  static const String typeRiddle = 'riddle';
  static const String typeMiniGame = 'mini_game';
  static const String typePattern = 'pattern';

  // All challenge types list
  static const List<String> allChallengeTypes = [
    typeMath,
    typeTrivia,
    typeWordGame,
    typePattern,
  ];

  // Double or Nothing
  static const double doubleOrNothingWinMultiplier = 2.0;
  static const double doubleOrNothingLoseMultiplier = 0.5;
  static const double doubleOrNothingChance = 0.2; // 20% chance to offer

  // Difficulty Thresholds by Level
  static const int easyMaxLevel = 5;
  static const int mediumMaxLevel = 15;

  // Get difficulty based on user level
  static String getDifficultyForLevel(int level) {
    if (level <= easyMaxLevel) return difficultyEasy;
    if (level <= mediumMaxLevel) return difficultyMedium;
    return difficultyHard;
  }

  // Calculate point reward with level scaling
  static int calculatePointReward(
    String difficulty,
    int userLevel, {
    bool isDoubleOrNothing = false,
  }) {
    final baseReward = basePointRewards[difficulty] ?? 10;

    // Add level bonus (1 point per level)
    final levelBonus = userLevel;

    var totalReward = baseReward + levelBonus;

    if (isDoubleOrNothing) {
      totalReward = (totalReward * doubleOrNothingWinMultiplier).round();
    }

    return totalReward;
  }

  // Calculate point loss for double-or-nothing failure
  static int calculatePointLoss(String difficulty, int userLevel) {
    final potentialReward = calculatePointReward(difficulty, userLevel);
    return (potentialReward * doubleOrNothingLoseMultiplier).round();
  }

  // Calculate XP reward with level scaling
  static int calculateXpReward(String difficulty, int userLevel) {
    final baseXp = baseXpRewards[difficulty] ?? 15;

    // Add small level scaling for XP
    final levelBonus = (userLevel * 0.5).round();

    return baseXp + levelBonus;
  }

  // Get time limit for difficulty
  static int getTimeLimit(String difficulty) {
    return timeLimits[difficulty] ?? 30;
  }
}
