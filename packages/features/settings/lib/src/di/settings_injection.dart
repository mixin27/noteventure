import 'package:database/database.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/settings_local_datasource.dart';
import '../data/repositories/settings_repository_impl.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/usecases/get_settings.dart';
import '../domain/usecases/reset_settings.dart';
import '../domain/usecases/update_settings.dart';
import '../domain/usecases/watch_settings.dart';
import '../presentation/bloc/settings_bloc.dart';

final getIt = GetIt.instance;

Future<void> initSettingsDependencies() async {
  // Data Sources
  getIt.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(getIt<AppSettingsDao>()),
  );

  // Repositories
  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(getIt<SettingsLocalDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetSettings(getIt<SettingsRepository>()));
  getIt.registerLazySingleton(
    () => UpdateSettings(getIt<SettingsRepository>()),
  );
  getIt.registerLazySingleton(() => ResetSettings(getIt<SettingsRepository>()));
  getIt.registerLazySingleton(() => WatchSettings(getIt<SettingsRepository>()));

  // BLoC
  getIt.registerFactory(
    () => SettingsBloc(
      getSettings: getIt<GetSettings>(),
      updateSettings: getIt<UpdateSettings>(),
      resetSettings: getIt<ResetSettings>(),
      watchSettings: getIt<WatchSettings>(),
    ),
  );
}
