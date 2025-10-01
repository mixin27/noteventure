import 'package:get_it/get_it.dart';
import 'package:database/database.dart';

import '../../points.dart';
import '../data/datasources/points_local_datasource.dart';
import '../data/repositories/points_repository_impl.dart';
import '../domain/repositories/points_repository.dart';
import '../domain/usecases/check_points.dart';
import '../domain/usecases/earn_points.dart';
import '../domain/usecases/get_point_balance.dart';
import '../domain/usecases/spend_points.dart';

final getIt = GetIt.instance;

void initPointsFeature() {
  // Data sources
  getIt.registerLazySingleton<PointsLocalDataSource>(
    () => PointsLocalDataSourceImpl(
      getIt<UserProgressDao>(),
      getIt<PointTransactionsDao>(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<PointsRepository>(
    () => PointsRepositoryImpl(getIt<PointsLocalDataSource>()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetPointBalance(getIt<PointsRepository>()));
  getIt.registerLazySingleton(() => CheckPoints(getIt<PointsRepository>()));
  getIt.registerLazySingleton(() => SpendPoints(getIt<PointsRepository>()));
  getIt.registerLazySingleton(() => EarnPoints(getIt<PointsRepository>()));

  // BLoC
  getIt.registerFactory(
    () => PointsBloc(
      getPointBalance: getIt<GetPointBalance>(),
      checkPoints: getIt<CheckPoints>(),
      spendPointsUseCase: getIt<SpendPoints>(),
      earnPointsUseCase: getIt<EarnPoints>(),
      repository: getIt<PointsRepository>(),
    ),
  );
}
