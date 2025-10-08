import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/auth_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> register({
    required String email,
    required String password,
    String? username,
  });

  Future<Either<Failure, AuthUser>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, bool>> isAuthenticated();

  Future<Either<Failure, AuthUser?>> getCurrentUser();
}
