import 'package:core/core.dart';
import 'package:dio/dio.dart';

abstract class SyncRemoteDataSource {
  Future<SyncResponse> syncData({required SyncRequest request});

  Future<SyncResponse> pullData({DateTime? lastSyncTimestamp});

  Future<SyncPushResponse> pushData({required SyncRequest request});
}

class SyncRemoteDataSourceImpl implements SyncRemoteDataSource {
  final SyncApiService _syncApiService;

  SyncRemoteDataSourceImpl({required SyncApiService syncApiService})
    : _syncApiService = syncApiService;

  @override
  Future<SyncResponse> syncData({required SyncRequest request}) async {
    try {
      final response = await _syncApiService.sync(request);
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<SyncResponse> pullData({DateTime? lastSyncTimestamp}) async {
    try {
      final lastSyncString = lastSyncTimestamp?.toIso8601String();
      final response = await _syncApiService.pull(lastSyncString);
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<SyncPushResponse> pushData({required SyncRequest request}) async {
    try {
      final response = await _syncApiService.push(request);
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
