import 'package:get_it/get_it.dart';

import '../network/api_services/auth_api_service.dart';
import '../network/dio_client.dart';
import '../storage/token_storage.dart';
import '../storage/user_storage.dart';

final getIt = GetIt.instance;

Future<void> initCoreInjection() async {
  // Core
  getIt.registerLazySingleton(() => TokenStorage());
  getIt.registerLazySingleton(() => UserStorage());
  getIt.registerLazySingleton(() => DioClient(tokenStorage: getIt()));

  // Auth API Service
  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(getIt<DioClient>().dio),
  );
}
