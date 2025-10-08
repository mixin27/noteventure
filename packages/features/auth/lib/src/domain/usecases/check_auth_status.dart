import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class CheckAuthStatus {
  final AuthRepository repository;

  CheckAuthStatus(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.isAuthenticated();
  }
}
