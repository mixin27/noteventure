import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../entities/challenge.dart';

class SubmitAnswer {
  Either<Failure, bool> call(SubmitAnswerParams params) {
    try {
      final userAnswer = params.userAnswer.trim().toLowerCase();
      final correctAnswer = params.challenge.correctAnswer.toLowerCase();

      final isCorrect = userAnswer == correctAnswer;

      return Right(isCorrect);
    } catch (e) {
      return Left(ChallengeFailure(e.toString()));
    }
  }
}

class SubmitAnswerParams {
  final Challenge challenge;
  final String userAnswer;

  const SubmitAnswerParams({required this.challenge, required this.userAnswer});
}
