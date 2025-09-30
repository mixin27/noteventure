/// Base exception for all custom exceptions
class AppException implements Exception {
  final String message;
  final dynamic cause;

  const AppException(this.message, [this.cause]);

  @override
  String toString() =>
      'AppException: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

/// Server-related exception
class ServerException extends AppException {
  final int? statusCode;

  const ServerException(super.message, [this.statusCode, super.cause]);

  @override
  String toString() =>
      'ServerException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Cache-related exception
class CacheException extends AppException {
  const CacheException(super.message, [super.cause]);
}

/// Database-related exception
class DatabaseException extends AppException {
  const DatabaseException(super.message, [super.cause]);
}

/// Insufficient points exception
class InsufficientPointsException extends AppException {
  final int required;
  final int current;

  const InsufficientPointsException({
    required this.required,
    required this.current,
  }) : super('Insufficient points: need $required, have $current');

  @override
  String toString() => message;
}

/// Network exception
class NetworkException extends AppException {
  const NetworkException(super.message, [super.cause]);
}

/// Validation exception
class ValidationException extends AppException {
  const ValidationException(super.message);
}

/// Note locked exception
class NoteLockedException extends AppException {
  final DateTime? unlockDate;

  NoteLockedException([this.unlockDate])
    : super('Note is locked until ${unlockDate?.toString() ?? "unknown"}');
}

/// Timeout exception
class TimeoutException extends AppException {
  const TimeoutException([super.message = 'Operation timed out']);
}

/// Not found exception
class NotFoundException extends AppException {
  const NotFoundException([super.message = 'Resource not found']);
}

/// Permission exception
class PermissionException extends AppException {
  const PermissionException([super.message = 'Permission denied']);
}
