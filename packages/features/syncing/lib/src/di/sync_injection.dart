import 'package:get_it/get_it.dart';

import '../data/datasources/sync_local_datasource.dart';
import '../data/datasources/sync_remote_datasource.dart';
import '../data/repositories/sync_repository_impl.dart';
import '../domain/repositories/sync_repository.dart';
import '../domain/usecases/get_last_sync_time.dart';
import '../domain/usecases/pull_from_server.dart';
import '../domain/usecases/push_to_server.dart';
import '../domain/usecases/sync_data.dart';
import '../presentation/bloc/sync_bloc.dart';

final getIt = GetIt.instance;

void initSyncingFeature() {
  // Sync Data Sources
  getIt.registerLazySingleton<SyncRemoteDataSource>(
    () => SyncRemoteDataSourceImpl(syncApiService: getIt()),
  );

  getIt.registerLazySingleton<SyncLocalDataSource>(
    () => SyncLocalDataSourceImpl(
      notesRepository: getIt(),
      progressRepository: getIt(),
      pointsRepository: getIt(),
      settingsRepository: getIt(),
    ),
  );

  // Sync Repository
  getIt.registerLazySingleton<SyncRepository>(
    () =>
        SyncRepositoryImpl(remoteDataSource: getIt(), localDataSource: getIt()),
  );

  // Sync Use Cases
  getIt.registerLazySingleton(() => SyncData(getIt()));
  getIt.registerLazySingleton(() => PullFromServer(getIt()));
  getIt.registerLazySingleton(() => PushToServer(getIt()));
  getIt.registerLazySingleton(() => GetLastSyncTime(getIt()));

  // Sync BLoC
  getIt.registerFactory(
    () => SyncBloc(
      syncData: getIt(),
      pullFromServer: getIt(),
      pushToServer: getIt(),
      getLastSyncTime: getIt(),
    ),
  );
}
