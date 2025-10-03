import 'package:database/database.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/achievements_local_datasource.dart';
import '../data/repositories/achievements_repository_impl.dart';
import '../domain/repositories/achievements_repository.dart';
import '../domain/usecases/get_all_chievements.dart';
import '../domain/usecases/get_unlocked_achivements.dart';
import '../domain/usecases/initialize_achievement.dart';
import '../domain/usecases/unlock_achievement.dart';
import '../domain/usecases/update_achievement_progress.dart';
import '../domain/usecases/watch_achievements.dart';
import '../presentation/bloc/achievements_bloc.dart';

final getIt = GetIt.instance;

void initAchievementsFeature() {
  // Data sources
  getIt.registerLazySingleton<AchievementsLocalDataSource>(
    () => AchievementsLocalDataSourceImpl(getIt<AchievementsDao>()),
  );

  // Repositories
  getIt.registerLazySingleton<AchievementsRepository>(
    () => AchievementsRepositoryImpl(getIt<AchievementsLocalDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton(
    () => GetAllAchievements(getIt<AchievementsRepository>()),
  );
  getIt.registerLazySingleton(
    () => GetUnlockedAchievements(getIt<AchievementsRepository>()),
  );
  getIt.registerLazySingleton(
    () => InitializeAchievements(getIt<AchievementsRepository>()),
  );
  getIt.registerLazySingleton(
    () => UnlockAchievement(getIt<AchievementsRepository>()),
  );
  getIt.registerLazySingleton(
    () => UpdateAchievementProgress(getIt<AchievementsRepository>()),
  );
  getIt.registerLazySingleton(
    () => WatchAchievements(getIt<AchievementsRepository>()),
  );

  // BLoC
  getIt.registerFactory(
    () => AchievementsBloc(
      getAllAchievements: getIt<GetAllAchievements>(),
      getUnlockedAchievements: getIt<GetUnlockedAchievements>(),
      updateAchievementProgress: getIt<UpdateAchievementProgress>(),
      unlockAchievement: getIt<UnlockAchievement>(),
      initializeAchievements: getIt<InitializeAchievements>(),
      watchAchievements: getIt<WatchAchievements>(),
    ),
  );
}
