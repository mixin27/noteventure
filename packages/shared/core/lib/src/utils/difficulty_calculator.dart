import '../constants/challenge_config.dart';

/// Utility class for calculating challenge difficulty
class DifficultyCalculator {
  // Prevent instantiation
  DifficultyCalculator._();

  /// Get appropriate difficulty for user level
  static String getDifficultyForLevel(int userLevel) {
    return ChallengeConfig.getDifficultyForLevel(userLevel);
  }

  /// Calculate numeric difficulty level (1-10)
  static int getNumericDifficulty(String difficulty, int userLevel) {
    final baseDifficulty = switch (difficulty) {
      ChallengeConfig.difficultyEasy => 2,
      ChallengeConfig.difficultyMedium => 5,
      ChallengeConfig.difficultyHard => 8,
      _ => 5,
    };

    // Add level-based scaling
    final levelModifier = (userLevel / 10).floor();
    final finalDifficulty = (baseDifficulty + levelModifier).clamp(1, 10);

    return finalDifficulty;
  }

  /// Determine if user should get a harder challenge
  static bool shouldIncreaseDifficulty(
    int correctStreak,
    double recentAccuracy,
  ) {
    // If user has a streak of 5+ and accuracy > 80%, increase difficulty
    return correctStreak >= 5 && recentAccuracy > 0.8;
  }

  /// Determine if user should get an easier challenge
  static bool shouldDecreaseDifficulty(
    int failureStreak,
    double recentAccuracy,
  ) {
    // If user has failed 3+ times and accuracy < 40%, decrease difficulty
    return failureStreak >= 3 && recentAccuracy < 0.4;
  }

  /// Calculate recommended difficulty based on performance
  static String getRecommendedDifficulty({
    required int userLevel,
    required int correctStreak,
    required int failureStreak,
    required double recentAccuracy,
  }) {
    final baseDifficulty = getDifficultyForLevel(userLevel);

    // Check if should adjust
    if (shouldIncreaseDifficulty(correctStreak, recentAccuracy)) {
      return switch (baseDifficulty) {
        ChallengeConfig.difficultyEasy => ChallengeConfig.difficultyMedium,
        ChallengeConfig.difficultyMedium => ChallengeConfig.difficultyHard,
        _ => baseDifficulty,
      };
    }

    if (shouldDecreaseDifficulty(failureStreak, recentAccuracy)) {
      return switch (baseDifficulty) {
        ChallengeConfig.difficultyHard => ChallengeConfig.difficultyMedium,
        ChallengeConfig.difficultyMedium => ChallengeConfig.difficultyEasy,
        _ => baseDifficulty,
      };
    }

    return baseDifficulty;
  }

  /// Generate random difficulty with weighted distribution
  static String getRandomDifficulty(int userLevel) {
    final baseDifficulty = getDifficultyForLevel(userLevel);
    final random = DateTime.now().millisecondsSinceEpoch % 100;

    // Weight distribution based on base difficulty
    return switch (baseDifficulty) {
      ChallengeConfig.difficultyEasy => switch (random) {
        < 70 => ChallengeConfig.difficultyEasy,
        < 95 => ChallengeConfig.difficultyMedium,
        _ => ChallengeConfig.difficultyHard,
      },
      ChallengeConfig.difficultyMedium => switch (random) {
        < 20 => ChallengeConfig.difficultyEasy,
        < 80 => ChallengeConfig.difficultyMedium,
        _ => ChallengeConfig.difficultyHard,
      },
      _ => switch (random) {
        < 10 => ChallengeConfig.difficultyEasy,
        < 40 => ChallengeConfig.difficultyMedium,
        _ => ChallengeConfig.difficultyHard,
      },
    };
  }
}
