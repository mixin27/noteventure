import 'package:equatable/equatable.dart';

/// Base class for all failures in the app
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

/// Database operation failed
class DatabaseFailure extends Failure {
  const DatabaseFailure([super.message = 'Database operation failed']);
}

/// Network operation failed
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network operation failed']);
}

/// User has insufficient points for an action
class InsufficientPointsFailure extends Failure {
  final int required;
  final int current;

  const InsufficientPointsFailure({
    required this.required,
    required this.current,
  }) : super('Insufficient points: need $required, have $current');

  @override
  List<Object?> get props => [required, current, message];
}

/// Challenge-related failure
class ChallengeFailure extends Failure {
  const ChallengeFailure([super.message = 'Challenge operation failed']);
}

/// Cache operation failed
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache operation failed']);
}

/// Validation failed
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}

/// Note is locked and cannot be accessed
class NoteLockedFailure extends Failure {
  final DateTime? unlockDate;

  const NoteLockedFailure([this.unlockDate]) : super('Note is locked');

  @override
  List<Object?> get props => [unlockDate, message];
}

/// Achievement already unlocked
class AchievementAlreadyUnlockedFailure extends Failure {
  const AchievementAlreadyUnlockedFailure()
    : super('Achievement already unlocked');
}

/// Server error
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure([super.message = 'Server error', this.statusCode]);

  @override
  List<Object?> get props => [statusCode, message];
}

/// Timeout error
class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Operation timed out']);
}

/// Not found error
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}

/// Permission denied
class PermissionFailure extends Failure {
  const PermissionFailure([super.message = 'Permission denied']);
}

/// Unknown error
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unknown error occurred']);
}
