import 'package:database/database.dart';
import 'package:get_it/get_it.dart';
import 'package:settings/settings.dart';

import '../data/datasources/chaos_local_datasource.dart';
import '../data/repositories/chaos_repository_impl.dart';
import '../domain/repositories/chaos_repository.dart';
import '../domain/usecases/get_recent_events.dart';
import '../domain/usecases/trigger_random_event.dart';
import '../domain/usecases/watch_chaos_events.dart';
import '../presentation/bloc/chaos_bloc.dart';

final getIt = GetIt.instance;

Future<void> initChaosDependencies() async {
  // Data Sources
  getIt.registerLazySingleton<ChaosLocalDataSource>(
    () => ChaosLocalDataSourceImpl(getIt<ChaosEventsDao>()),
  );

  // Repositories
  getIt.registerLazySingleton<ChaosRepository>(
    () => ChaosRepositoryImpl(getIt<ChaosLocalDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetRecentEvents(getIt<ChaosRepository>()));
  getIt.registerLazySingleton(
    () => TriggerRandomEvent(getIt<ChaosRepository>()),
  );
  getIt.registerLazySingleton(() => WatchChaosEvents(getIt<ChaosRepository>()));

  // BLoC
  getIt.registerFactory(
    () => ChaosBloc(
      getRecentEvents: getIt<GetRecentEvents>(),
      triggerRandomEvent: getIt<TriggerRandomEvent>(),
      watchChaosEvents: getIt<WatchChaosEvents>(),
      watchSettings: getIt<WatchSettings>(),
    ),
  );
}
