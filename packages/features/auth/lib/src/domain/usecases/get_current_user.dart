import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<Failure, AuthUser?>> call() async {
    return await repository.getCurrentUser();
  }
}
