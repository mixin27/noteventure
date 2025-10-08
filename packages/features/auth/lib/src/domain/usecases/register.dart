import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<Either<Failure, AuthUser>> call(RegisterParams params) async {
    return await repository.register(
      email: params.email,
      password: params.password,
      username: params.username,
    );
  }
}

class RegisterParams {
  final String email;
  final String password;
  final String? username;

  RegisterParams({required this.email, required this.password, this.username});
}
