import 'dart:math';

/// Utility class for generating random fun messages
class MessageGenerator {
  // Prevent instantiation
  MessageGenerator._();

  static final Random _random = Random();

  // =========================================================================
  // Correct Answer Messages
  // =========================================================================

  static const List<String> _sarcasticCorrect = [
    'Wow, you got one right! 🎉',
    'Correct! Even a broken clock is right twice a day.',
    'Nice! You\'re smarter than my pet rock.',
    'Correct! You\'re on fire... or is that just my phone overheating?',
    'Right answer! Did you guess or actually think?',
  ];

  static const List<String> _wholesomeCorrect = [
    'Excellent work! Keep it up! 💪',
    'You\'re doing great! 🌟',
    'Brilliant! Your brain is amazing! 🧠',
    'Perfect! You\'re a star! ⭐',
    'Wonderful! I knew you could do it! 🎊',
  ];

  static const List<String> _chaoticCorrect = [
    'CORRECT! *confetti explosion* 🎊',
    'YES! The universe approves! ✨',
    'BOOM! Nailed it! 💥',
    'DING DING DING! Winner! 🔔',
    '*chef\'s kiss* Perfection! 👨‍🍳',
  ];

  static const List<String> _deadpanCorrect = [
    'Correct.',
    'That is the right answer.',
    'You have answered correctly.',
    'Affirmative.',
    'Yes, that\'s correct.',
  ];

  // =========================================================================
  // Wrong Answer Messages
  // =========================================================================

  static const List<String> _sarcasticWrong = [
    'Ouch. Maybe try coffee first? ☕',
    'That\'s... creative. But wrong.',
    'Nice try! And by nice, I mean not nice.',
    'So close! If we were playing horseshoes.',
    'Nope! But thanks for playing!',
  ];

  static const List<String> _wholesomeWrong = [
    'Not quite, but don\'t give up! 💪',
    'Almost! You\'ll get it next time! 🌟',
    'Good try! Learning is a journey! 📚',
    'Don\'t worry, mistakes help us grow! 🌱',
    'Keep going! You\'re improving! 🎯',
  ];

  static const List<String> _chaoticWrong = [
    'NOPE! *sad trombone* 📯',
    'WRONG! But I still love you! ❤️',
    '*error sound* Try again! 🔊',
    'Oopsie daisy! 🌼',
    'DENIED! *gavel slam* ⚖️',
  ];

  static const List<String> _deadpanWrong = [
    'Incorrect.',
    'That is not the right answer.',
    'You have answered incorrectly.',
    'Negative.',
    'No, that is wrong.',
  ];

  // =========================================================================
  // Random App Messages
  // =========================================================================

  static const List<String> _randomMessages = [
    'Your notes miss you. Consider visiting them.',
    'Remember: with great points comes great responsibility.',
    'Fun fact: You\'ve spent {time} using this app!',
    'Your brain is doing great today! 🧠',
    'Coffee break? No? Okay, keep going! ☕',
    'Achievement unlocked: Reading random messages!',
    'This message is brought to you by procrastination.',
    'Did you know? Knowing things earns points!',
    'Plot twist: This app is actually helping you!',
    'Still here? You must really like challenges!',
  ];

  // =========================================================================
  // Chaos Event Messages
  // =========================================================================

  static const List<String> _chaosPositiveMessages = [
    'The chaos gods smile upon you! 😇',
    'Lucky day! The universe is on your side! ✨',
    'Jackpot! Today is your day! 🎰',
    'Surprise! Good things happen! 🎁',
    'The stars have aligned! 🌟',
  ];

  static const List<String> _chaosNegativeMessages = [
    'The chaos gods are feeling mischievous! 😈',
    'Uh oh... things just got interesting! 🌪️',
    'Plot twist incoming! 🎬',
    'Well, this is awkward... 😬',
    'Challenge accepted? Ready or not! ⚡',
  ];

  static const List<String> _chaosNeutralMessages = [
    'The app is thinking... 🤔',
    '*mysterious music plays* 🎵',
    'Something is happening... or is it? 👀',
    'Just passing by, don\'t mind me! 👻',
    'This is fine. Everything is fine. 🔥',
  ];

  // =========================================================================
  // Public Methods
  // =========================================================================

  /// Get a random correct answer message based on personality
  static String getCorrectMessage(String personality) {
    final messages = switch (personality.toLowerCase()) {
      'sarcastic' => _sarcasticCorrect,
      'wholesome' => _wholesomeCorrect,
      'chaotic' => _chaoticCorrect,
      'deadpan' => _deadpanCorrect,
      'random' => [
        ..._sarcasticCorrect,
        ..._wholesomeCorrect,
        ..._chaoticCorrect,
        ..._deadpanCorrect,
      ],
      _ => _wholesomeCorrect,
    };

    return messages[_random.nextInt(messages.length)];
  }

  /// Get a random wrong answer message based on personality
  static String getWrongMessage(String personality) {
    final messages = switch (personality.toLowerCase()) {
      'sarcastic' => _sarcasticWrong,
      'wholesome' => _wholesomeWrong,
      'chaotic' => _chaoticWrong,
      'deadpan' => _deadpanWrong,
      'random' => [
        ..._sarcasticWrong,
        ..._wholesomeWrong,
        ..._chaoticWrong,
        ..._deadpanWrong,
      ],
      _ => _wholesomeWrong,
    };

    return messages[_random.nextInt(messages.length)];
  }

  /// Get a random app message
  static String getRandomMessage() {
    return _randomMessages[_random.nextInt(_randomMessages.length)];
  }

  /// Get a chaos event message based on type
  static String getChaosMessage(String eventType) {
    final messages = switch (eventType.toLowerCase()) {
      'positive' => _chaosPositiveMessages,
      'negative' => _chaosNegativeMessages,
      'neutral' => _chaosNeutralMessages,
      _ => _chaosNeutralMessages,
    };

    return messages[_random.nextInt(messages.length)];
  }

  /// Get a level up message
  static String getLevelUpMessage(int newLevel) {
    final messages = [
      'Level $newLevel! You\'re unstoppable! 🚀',
      'LEVEL UP! Welcome to level $newLevel! 🎊',
      'Congratulations! Level $newLevel achieved! 🏆',
      'You\'ve reached level $newLevel! Keep climbing! ⛰️',
      'Level $newLevel unlocked! You\'re amazing! ⭐',
    ];

    return messages[_random.nextInt(messages.length)];
  }

  /// Get an achievement unlock message
  static String getAchievementMessage(String achievementName) {
    final messages = [
      'Achievement Unlocked: $achievementName! 🏆',
      'NEW ACHIEVEMENT: $achievementName! 🎖️',
      'You earned: $achievementName! 🌟',
      'CONGRATS! $achievementName unlocked! 🎉',
      'Badge earned: $achievementName! 🏅',
    ];

    return messages[_random.nextInt(messages.length)];
  }

  /// Get a streak message
  static String getStreakMessage(int streakCount) {
    if (streakCount < 3) {
      return 'Streak: $streakCount! Keep going! 🔥';
    } else if (streakCount < 5) {
      return '$streakCount in a row! You\'re on fire! 🔥🔥';
    } else if (streakCount < 10) {
      return 'WOW! $streakCount streak! Unstoppable! 🔥🔥🔥';
    } else {
      return 'LEGENDARY! $streakCount streak! Are you even human?! 🔥🔥🔥🔥';
    }
  }

  /// Get an insufficient points message
  static String getInsufficientPointsMessage(int needed, int have) {
    final shortfall = needed - have;
    final messages = [
      'Oops! You need $shortfall more points.',
      'Not enough points! Need $needed, have $have.',
      'Short by $shortfall points. Time for a challenge! 💪',
      'You\'re $shortfall points away from this action.',
      'Insufficient funds! (Need $shortfall more points)',
    ];

    return messages[_random.nextInt(messages.length)];
  }
}
