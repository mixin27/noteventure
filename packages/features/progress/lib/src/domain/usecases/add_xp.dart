import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../repositories/progress_repository.dart';

class AddXp {
  final ProgressRepository repository;

  AddXp(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(int amount) async {
    return await repository.addXp(amount);
  }
}
