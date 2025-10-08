import 'package:core/core.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponse> register({
    required String email,
    required String password,
    String? username,
  });

  Future<AuthResponse> login({required String email, required String password});

  Future<void> logout();

  Future<Map<String, dynamic>?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService _authApiService;
  final TokenStorage _tokenStorage;
  final UserStorage _userStorage;
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl({
    required AuthApiService authApiService,
    required TokenStorage tokenStorage,
    required UserStorage userStorage,
    required DioClient dioClient,
  }) : _authApiService = authApiService,
       _tokenStorage = tokenStorage,
       _userStorage = userStorage,
       _dioClient = dioClient;

  @override
  Future<AuthResponse> register({
    required String email,
    required String password,
    String? username,
  }) async {
    try {
      final request = RegisterRequest(
        email: email,
        password: password,
        username: username,
      );

      final response = await _authApiService.register(request);

      // Save tokens
      await _tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        userId: response.user.id,
      );

      // Save user data
      await _userStorage.saveUser(
        id: response.user.id,
        email: response.user.email,
        username: response.user.username,
        createdAt: response.user.createdAt,
        updatedAt: response.user.updatedAt,
        isActive: response.user.isActive,
      );

      // Update dio client with token
      await _dioClient.updateToken(response.accessToken);

      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(email: email, password: password);

      final response = await _authApiService.login(request);

      // Save tokens
      await _tokenStorage.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        userId: response.user.id,
      );

      // Save user data
      await _userStorage.saveUser(
        id: response.user.id,
        email: response.user.email,
        username: response.user.username,
        createdAt: response.user.createdAt,
        updatedAt: response.user.updatedAt,
        isActive: response.user.isActive,
      );

      // Update dio client with token
      await _dioClient.updateToken(response.accessToken);

      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Clear tokens and user data
      await _tokenStorage.clearTokens();
      await _userStorage.clearUser();
      await _dioClient.clearToken();
    } catch (e) {
      throw ApiException(message: 'Logout failed: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      return await _userStorage.getUser();
    } catch (e) {
      throw ApiException(message: 'Failed to get current user: $e');
    }
  }
}
