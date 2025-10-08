import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(message: 'Connection timeout', statusCode: null);
      case DioExceptionType.sendTimeout:
        return ApiException(message: 'Send timeout', statusCode: null);
      case DioExceptionType.receiveTimeout:
        return ApiException(message: 'Receive timeout', statusCode: null);
      case DioExceptionType.badResponse:
        return ApiException(
          message: _parseErrorMessage(error.response),
          statusCode: error.response?.statusCode,
          data: error.response?.data,
        );
      case DioExceptionType.cancel:
        return ApiException(message: 'Request cancelled', statusCode: null);
      case DioExceptionType.unknown:
        return ApiException(
          message: error.message ?? 'Unknown error occurred',
          statusCode: null,
        );
      default:
        return ApiException(message: 'Something went wrong', statusCode: null);
    }
  }

  static String _parseErrorMessage(Response? response) {
    if (response?.data is Map) {
      final data = response!.data as Map<String, dynamic>;
      return data['error'] ?? data['message'] ?? 'Server error';
    }
    return 'Server error';
  }

  @override
  String toString() => message;
}
