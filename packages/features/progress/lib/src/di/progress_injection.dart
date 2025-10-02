import 'package:database/database.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/progress_local_datasource.dart';
import '../data/repositories/progress_repository_impl.dart';
import '../domain/repositories/progress_repository.dart';
import '../domain/usecases/add_xp.dart';
import '../domain/usecases/get_user_progress.dart';
import '../domain/usecases/update_streak.dart';
import '../presentation/bloc/progress_bloc.dart';

final getIt = GetIt.instance;

void initProgressFeature() {
  // Data sources
  getIt.registerLazySingleton<ProgressLocalDataSource>(
    () => ProgressLocalDataSourceImpl(getIt<UserProgressDao>()),
  );

  // Repositories
  getIt.registerLazySingleton<ProgressRepository>(
    () => ProgressRepositoryImpl(getIt<ProgressLocalDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton(
    () => GetUserProgress(getIt<ProgressRepository>()),
  );
  getIt.registerLazySingleton(() => AddXp(getIt<ProgressRepository>()));
  getIt.registerLazySingleton(() => UpdateStreak(getIt<ProgressRepository>()));

  // BLoC
  getIt.registerFactory(
    () => ProgressBloc(
      getUserProgress: getIt<GetUserProgress>(),
      addXp: getIt<AddXp>(),
      updateStreak: getIt<UpdateStreak>(),
      repository: getIt<ProgressRepository>(),
    ),
  );
}
