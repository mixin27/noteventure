import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../entities/challenge.dart';

class GenerateChallenge {
  Future<Either<Failure, Challenge>> call(
    GenerateChallengeParams params,
  ) async {
    try {
      // For now, generate challenges locally
      final challenge = _generateLocalChallenge(params.type, params.difficulty);
      return Right(challenge);
    } catch (e) {
      return Left(ChallengeFailure(e.toString()));
    }
  }

  Challenge _generateLocalChallenge(ChallengeType? type, String difficulty) {
    final random = DateTime.now().millisecondsSinceEpoch;
    final selectedType = type ?? _randomType(random);

    return switch (selectedType) {
      ChallengeType.math => _generateMathChallenge(difficulty, random),
      ChallengeType.trivia => _generateTriviaChallenge(difficulty, random),
      ChallengeType.wordGame => _generateWordGameChallenge(difficulty, random),
      ChallengeType.pattern => _generatePatternChallenge(difficulty, random),
    };
  }

  ChallengeType _randomType(int seed) {
    final index = seed % ChallengeType.values.length;
    return ChallengeType.values[index];
  }

  Challenge _generateMathChallenge(String difficulty, int seed) {
    final pointReward = ChallengeConfig.basePointRewards[difficulty] ?? 10;
    final xpReward = ChallengeConfig.baseXpRewards[difficulty] ?? 15;
    final timeLimit = ChallengeConfig.timeLimits[difficulty] ?? 30;

    int num1, num2, answer;
    String operator;
    String question;

    switch (difficulty) {
      case 'easy':
        num1 = (seed % 20) + 1;
        num2 = (seed % 10) + 1;
        if (seed % 2 == 0) {
          operator = '+';
          answer = num1 + num2;
        } else {
          operator = '-';
          answer = num1 - num2;
        }
        break;
      case 'medium':
        num1 = (seed % 50) + 10;
        num2 = (seed % 12) + 2;
        if (seed % 3 == 0) {
          operator = '×';
          answer = num1 * num2;
        } else {
          operator = '+';
          answer = num1 + num2;
        }
        break;
      case 'hard':
      default:
        num1 = (seed % 100) + 20;
        num2 = (seed % 15) + 3;
        if (seed % 2 == 0) {
          operator = '×';
          answer = num1 * num2;
        } else {
          operator = '÷';
          num1 = num1 * num2; // Make it divide evenly
          answer = num1 ~/ num2;
        }
        break;
    }

    question = '$num1 $operator $num2 = ?';

    return Challenge(
      id: 'math_$seed',
      type: ChallengeType.math,
      difficulty: difficulty,
      question: question,
      correctAnswer: answer.toString(),
      pointReward: pointReward,
      xpReward: xpReward,
      timeLimit: timeLimit,
    );
  }

  Challenge _generateTriviaChallenge(String difficulty, int seed) {
    final pointReward = ChallengeConfig.basePointRewards[difficulty] ?? 10;
    final xpReward = ChallengeConfig.baseXpRewards[difficulty] ?? 15;
    final timeLimit = ChallengeConfig.timeLimits[difficulty] ?? 30;

    // Simple trivia questions pool
    final triviaQuestions = [
      {
        'question': 'What is the capital of France?',
        'answer': 'Paris',
        'options': ['London', 'Paris', 'Berlin', 'Madrid'],
      },
      {
        'question': 'How many continents are there?',
        'answer': '7',
        'options': ['5', '6', '7', '8'],
      },
      {
        'question': 'What is the largest planet in our solar system?',
        'answer': 'Jupiter',
        'options': ['Mars', 'Saturn', 'Jupiter', 'Neptune'],
      },
      {
        'question': 'What is 2 + 2 × 2?',
        'answer': '6',
        'options': ['6', '8', '4', '10'],
      },
      {
        'question': 'How many days are in a leap year?',
        'answer': '366',
        'options': ['365', '366', '364', '367'],
      },
      {
        'question': 'What is the chemical symbol for water?',
        'answer': 'H2O',
        'options': ['H2O', 'O2', 'CO2', 'N2'],
      },
      {
        'question': 'How many legs does a spider have?',
        'answer': '8',
        'options': ['6', '8', '10', '12'],
      },
      {
        'question': 'What color is the sky on a clear day?',
        'answer': 'Blue',
        'options': ['Red', 'Blue', 'Green', 'Yellow'],
      },
      {
        'question': 'How many minutes are in an hour?',
        'answer': '60',
        'options': ['50', '60', '70', '100'],
      },
      {
        'question': 'What is the freezing point of water in Celsius?',
        'answer': '0',
        'options': ['0', '32', '100', '-10'],
      },
    ];

    final index = seed % triviaQuestions.length;
    final trivia = triviaQuestions[index];

    return Challenge(
      id: 'trivia_$seed',
      type: ChallengeType.trivia,
      difficulty: difficulty,
      question: trivia['question'] as String,
      correctAnswer: trivia['answer'] as String,
      options: trivia['options'] as List<String>,
      pointReward: pointReward,
      xpReward: xpReward,
      timeLimit: timeLimit,
    );
  }

  Challenge _generateWordGameChallenge(String difficulty, int seed) {
    final pointReward = ChallengeConfig.basePointRewards[difficulty] ?? 10;
    final xpReward = ChallengeConfig.baseXpRewards[difficulty] ?? 15;
    final timeLimit = ChallengeConfig.timeLimits[difficulty] ?? 30;

    final words = [
      'FLUTTER',
      'DART',
      'MOBILE',
      'CODE',
      'DEBUG',
      'BUILD',
      'WIDGET',
      'STATE',
      'ASYNC',
      'FUTURE',
    ];

    final word = words[seed % words.length];
    final scrambled = _scrambleWord(word, seed);

    return Challenge(
      id: 'word_$seed',
      type: ChallengeType.wordGame,
      difficulty: difficulty,
      question: 'Unscramble this word: $scrambled',
      correctAnswer: word,
      pointReward: pointReward,
      xpReward: xpReward,
      timeLimit: timeLimit,
    );
  }

  String _scrambleWord(String word, int seed) {
    final chars = word.split('');
    for (int i = chars.length - 1; i > 0; i--) {
      final j = (seed + i) % (i + 1);
      final temp = chars[i];
      chars[i] = chars[j];
      chars[j] = temp;
    }
    return chars.join();
  }

  Challenge _generatePatternChallenge(String difficulty, int seed) {
    final pointReward = ChallengeConfig.basePointRewards[difficulty] ?? 10;
    final xpReward = ChallengeConfig.baseXpRewards[difficulty] ?? 15;
    final timeLimit = ChallengeConfig.timeLimits[difficulty] ?? 30;

    final start = (seed % 10) + 1;
    final diff = (seed % 5) + 2;

    final sequence = [start, start + diff, start + diff * 2, start + diff * 3];

    final answer = start + diff * 4;

    return Challenge(
      id: 'pattern_$seed',
      type: ChallengeType.pattern,
      difficulty: difficulty,
      question: 'What comes next? ${sequence.join(', ')}, ?',
      correctAnswer: answer.toString(),
      pointReward: pointReward,
      xpReward: xpReward,
      timeLimit: timeLimit,
    );
  }
}

class GenerateChallengeParams {
  final ChallengeType? type;
  final String difficulty;

  const GenerateChallengeParams({this.type, this.difficulty = 'easy'});
}
