import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../storage/token_storage.dart';
import 'api_config.dart';

class DioClient {
  static DioClient? _instance;
  late Dio _dio;
  final TokenStorage _tokenStorage;

  DioClient._internal({TokenStorage? tokenStorage})
    : _tokenStorage = tokenStorage ?? TokenStorage() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: ApiConfig.defaultHeaders,
      ),
    );

    _setupInterceptors();
  }

  factory DioClient({TokenStorage? tokenStorage}) {
    _instance ??= DioClient._internal(tokenStorage: tokenStorage);
    return _instance!;
  }

  Dio get dio => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    // Add auth interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add token to headers if available
          final token = await _getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          // Handle 401 Unauthorized
          if (error.response?.statusCode == 401) {
            await _tokenStorage.clearTokens();
            // todo(mixin27): Navigate to login or refresh token
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<String?> _getToken() async {
    return _tokenStorage.getAccessToken();
  }

  Future<void> updateToken(String token) async {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<void> clearToken() async {
    _dio.options.headers.remove('Authorization');
    await _tokenStorage.clearTokens();
  }
}
