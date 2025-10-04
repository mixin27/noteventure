import 'package:database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:points/points.dart';

import '../data/datasources/themes_local_datasource.dart';
import '../data/repositories/themes_repository_impl.dart';
import '../domain/repositories/themes_repository.dart';
import '../domain/usecases/activate_theme.dart';
import '../domain/usecases/get_active_theme.dart';
import '../domain/usecases/get_all_themes.dart';
import '../domain/usecases/get_unlocked_themes.dart';
import '../domain/usecases/initialize_theme.dart';
import '../domain/usecases/unlock_theme.dart';
import '../domain/usecases/watch_active_theme.dart';
import '../domain/usecases/watch_themes.dart';
import '../presentation/bloc/themes_bloc.dart';

final getIt = GetIt.instance;

void initThemesFeature() {
  // Data sources
  getIt.registerLazySingleton<ThemesLocalDataSource>(
    () => ThemesLocalDataSourceImpl(getIt<ThemesDao>()),
  );

  // Repositories
  getIt.registerLazySingleton<ThemesRepository>(
    () => ThemesRepositoryImpl(getIt<ThemesLocalDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetAllThemes(getIt<ThemesRepository>()));
  getIt.registerLazySingleton(
    () => GetUnlockedThemes(getIt<ThemesRepository>()),
  );
  getIt.registerLazySingleton(() => GetActiveTheme(getIt<ThemesRepository>()));
  getIt.registerLazySingleton(() => UnlockTheme(getIt<ThemesRepository>()));
  getIt.registerLazySingleton(() => ActivateTheme(getIt<ThemesRepository>()));
  getIt.registerLazySingleton(
    () => InitializeThemes(getIt<ThemesRepository>()),
  );
  getIt.registerLazySingleton(() => WatchThemes(getIt<ThemesRepository>()));
  getIt.registerLazySingleton(
    () => WatchActiveTheme(getIt<ThemesRepository>()),
  );

  // BLoC
  getIt.registerFactory(
    () => ThemesBloc(
      getAllThemes: getIt<GetAllThemes>(),
      getUnlockedThemes: getIt<GetUnlockedThemes>(),
      getActiveTheme: getIt<GetActiveTheme>(),
      unlockTheme: getIt<UnlockTheme>(),
      activateTheme: getIt<ActivateTheme>(),
      initializeThemes: getIt<InitializeThemes>(),
      watchThemes: getIt<WatchThemes>(),
      watchActiveTheme: getIt<WatchActiveTheme>(),
      pointsBloc: getIt<PointsBloc>(),
    ),
  );
}
