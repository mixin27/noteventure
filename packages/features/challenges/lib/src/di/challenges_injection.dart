import 'package:get_it/get_it.dart';
import 'package:points/points.dart';
import 'package:settings/settings.dart';

import '../domain/usecases/generate_challenge.dart';
import '../domain/usecases/submit_answer.dart';
import '../presentation/bloc/challenge_bloc.dart';

final getIt = GetIt.instance;

void initChallengesFeature() {
  // Use cases
  getIt.registerLazySingleton(() => GenerateChallenge());
  getIt.registerLazySingleton(() => SubmitAnswer());

  // BLoC
  getIt.registerFactory(
    () => ChallengeBloc(
      generateChallenge: getIt<GenerateChallenge>(),
      submitAnswer: getIt<SubmitAnswer>(),
      pointsBloc: getIt<PointsBloc>(),
      watchSettings: getIt<WatchSettings>(),
    ),
  );
}
