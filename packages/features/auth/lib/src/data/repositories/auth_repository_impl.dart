import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final TokenStorage tokenStorage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.tokenStorage,
  });

  @override
  Future<Either<Failure, AuthUser>> register({
    required String email,
    required String password,
    String? username,
  }) async {
    try {
      final response = await remoteDataSource.register(
        email: email,
        password: password,
        username: username,
      );

      return Right(AuthUserModel.fromApi(response).toEntity());
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.login(
        email: email,
        password: password,
      );

      return Right(AuthUserModel.fromApi(response).toEntity());
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final tokenStorage = TokenStorage();
      final hasToken = await tokenStorage.hasValidToken();
      return Right(hasToken);
    } catch (e) {
      return Left(CacheFailure('Failed to check authentication status'));
    }
  }

  @override
  Future<Either<Failure, AuthUser?>> getCurrentUser() async {
    try {
      // Check if has valid token
      final hasToken = await tokenStorage.hasValidToken();
      if (!hasToken) {
        return const Right(null);
      }

      // Get user data from storage
      final userData = await remoteDataSource.getCurrentUser();
      if (userData == null) {
        return const Right(null);
      }

      // Get tokens
      final accessToken = await tokenStorage.getAccessToken();
      final refreshToken = await tokenStorage.getRefreshToken();

      if (accessToken == null || refreshToken == null) {
        return const Right(null);
      }

      // Reconstruct AuthUser
      final user = AuthUserModel.fromStorage(
        id: userData['id'],
        email: userData['email'],
        username: userData['username'],
        accessToken: accessToken,
        refreshToken: refreshToken,
        createdAt: DateTime.parse(userData['created_at']),
        updatedAt: DateTime.parse(userData['updated_at']),
        isActive: userData['is_active'],
      );

      return Right(user.toEntity());
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to get current user: $e'));
    }
  }
}
