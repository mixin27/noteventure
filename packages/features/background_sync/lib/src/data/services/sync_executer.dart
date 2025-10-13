import 'dart:io';

import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:syncing/syncing.dart' as sync;
import 'package:notes/notes.dart' as notes;
import 'package:points/points.dart' as points;
import 'package:progress/progress.dart' as progress;
import 'package:settings/settings.dart' as settings;
import 'package:syncing/syncing.dart';

/// Executes sync operation in background isolate
class SyncExecutor {
  /// Initialize dependencies for background isolate
  Future<void> initialize(GetIt getIt) async {
    debugPrint('[SyncExecutor] ═══════════════════════════════════════');
    debugPrint('[SyncExecutor] Starting dependency initialization...');
    debugPrint('[SyncExecutor] ═══════════════════════════════════════');

    try {
      // Database
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'noteventure.db'));
      final database = AppDatabase(NativeDatabase(file));
      getIt.registerSingleton<AppDatabase>(database);

      // Daos
      getIt.registerLazySingleton<NotesDao>(() => database.notesDao);
      getIt.registerLazySingleton<PointTransactionsDao>(
        () => database.pointTransactionsDao,
      );
      getIt.registerLazySingleton<UserProgressDao>(
        () => database.userProgressDao,
      );
      getIt.registerLazySingleton<AppSettingsDao>(
        () => database.appSettingsDao,
      );
      getIt.registerLazySingleton<SyncLogsDao>(() => database.syncLogsDao);

      // Http Client
      const apiBaseUrl = ApiConfig.baseUrl;
      final dioClient = DioClient(baseUrl: apiBaseUrl);
      getIt.registerSingleton<DioClient>(dioClient);

      final syncApiService = SyncApiService(dioClient.dio, baseUrl: apiBaseUrl);
      getIt.registerSingleton<SyncApiService>(syncApiService);

      // Features
      final notesLocalDataSource = notes.NotesLocalDataSourceImpl(
        getIt<NotesDao>(),
      );
      final notesRepository = notes.NotesRepositoryImpl(notesLocalDataSource);
      getIt.registerSingleton<notes.NotesRepository>(notesRepository);

      final pointsLocalDataSource = points.PointsLocalDataSourceImpl(
        getIt<UserProgressDao>(),
        getIt<PointTransactionsDao>(),
      );
      final pointsRepository = points.PointsRepositoryImpl(
        pointsLocalDataSource,
      );

      getIt.registerSingleton<points.PointsRepository>(pointsRepository);

      final progressLocalDataSource = progress.ProgressLocalDataSourceImpl(
        getIt<UserProgressDao>(),
      );
      final progressRepository = progress.ProgressRepositoryImpl(
        progressLocalDataSource,
      );
      getIt.registerSingleton<progress.ProgressRepository>(progressRepository);

      final settingsLocalDataSource = settings.SettingsLocalDataSourceImpl(
        getIt<AppSettingsDao>(),
      );
      final settingsRepository = settings.SettingsRepositoryImpl(
        settingsLocalDataSource,
      );
      getIt.registerSingleton<settings.SettingsRepository>(settingsRepository);

      final syncRemoteDataSource = sync.SyncRemoteDataSourceImpl(
        syncApiService: getIt<SyncApiService>(),
      );
      final syncLocalDataSource = sync.SyncLocalDataSourceImpl(
        notesRepository: getIt<notes.NotesRepository>(),
        progressRepository: getIt<progress.ProgressRepository>(),
        pointsRepository: getIt<points.PointsRepository>(),
        settingsRepository: getIt<settings.SettingsRepository>(),
      );

      final syncHistoryLocalDataSource = sync.SyncHistoryLocalDataSourceImpl(
        getIt<SyncLogsDao>(),
      );
      final syncRepository = sync.SyncRepositoryImpl(
        remoteDataSource: syncRemoteDataSource,
        localDataSource: syncLocalDataSource,
        syncHistoryLocalDataSource: syncHistoryLocalDataSource,
      );

      final syncHistoryRepository = sync.SyncHistoryRepositoryImpl(
        syncHistoryLocalDataSource,
      );
      getIt.registerSingleton<sync.SyncHistoryRepository>(
        syncHistoryRepository,
      );
      getIt.registerSingleton<sync.SyncRepository>(syncRepository);
    } catch (e, stackTrace) {
      debugPrint('[SyncExecutor] ═══════════════════════════════════════');
      debugPrint('[SyncExecutor] ❌ INITIALIZATION FAILED');
      debugPrint('[SyncExecutor] Final error: $e');
      debugPrint('[SyncExecutor] Full stack trace:');
      debugPrint(stackTrace.toString());
      debugPrint('[SyncExecutor] ═══════════════════════════════════════');
      rethrow;
    }
  }

  /// Perform the sync operation
  Future<bool> performSync(GetIt getIt) async {
    final startTime = DateTime.now();

    try {
      final syncRepository = getIt<sync.SyncRepository>();

      // Perform sync
      final result = await syncRepository.sync();

      return result.fold(
        (failure) {
          debugPrint('[SyncExecutor] ❌ Sync failed: ${failure.message}');
          return false;
        },
        (syncResult) {
          return true;
        },
      );
    } catch (e, stackTrace) {
      await _logBackgroundSync(
        getIt,
        success: false,
        error: e.toString(),
        duration: DateTime.now().difference(startTime),
      );

      debugPrint('[SyncExecutor] ❌ Sync error: $e');
      debugPrint('[SyncExecutor] Stack: $stackTrace');
      return false;
    }
  }

  /// Clean up resources
  Future<void> dispose(GetIt getIt) async {
    debugPrint('[SyncExecutor] Cleaning up...');

    try {
      if (getIt.isRegistered<AppDatabase>()) {
        final database = getIt<AppDatabase>();
        await database.close();
      }

      await getIt.reset();
    } catch (e) {
      debugPrint('[SyncExecutor] Cleanup error: $e');
    }
  }

  Future<void> _logBackgroundSync(
    GetIt getIt, {
    required bool success,
    SyncResult? result,
    String? error,
    required Duration duration,
  }) async {
    final repository = getIt<SyncHistoryRepository>();
    final logResult = await repository.logSync(
      syncType: SyncType.background,
      success: success,
      duration: duration,
      result: result,
      error: error,
    );
    logResult.fold(
      (failure) => debugPrint("SyncLog added failed: ${failure.message}"),
      (syncLog) => debugPrint(
        "SyncLog added for ${syncLog.id} - ${syncLog.syncType.name}",
      ),
    );
  }
}
