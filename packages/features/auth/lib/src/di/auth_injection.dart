import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/check_auth_status.dart';
import '../domain/usecases/get_current_user.dart';
import '../domain/usecases/login.dart';
import '../domain/usecases/logout.dart';
import '../domain/usecases/register.dart';
import '../presentation/auth_state_notifier.dart';
import '../presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> initAuthFeature() async {
  // Auth Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      authApiService: getIt<AuthApiService>(),
      tokenStorage: getIt<TokenStorage>(),
      userStorage: getIt<UserStorage>(),
      dioClient: getIt<DioClient>(),
    ),
  );

  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      tokenStorage: getIt<TokenStorage>(),
    ),
  );

  // Auth Use Cases
  getIt.registerLazySingleton(() => Register(getIt()));
  getIt.registerLazySingleton(() => Login(getIt()));
  getIt.registerLazySingleton(() => Logout(getIt()));
  getIt.registerLazySingleton(() => CheckAuthStatus(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUser(getIt()));

  // Auth BLoC
  getIt.registerFactory(
    () => AuthBloc(
      register: getIt<Register>(),
      login: getIt<Login>(),
      logout: getIt<Logout>(),
      checkAuthStatus: getIt<CheckAuthStatus>(),
      getCurrentUser: getIt<GetCurrentUser>(),
    ),
  );

  getIt.registerLazySingleton(() => AuthStateNotifier());
}
