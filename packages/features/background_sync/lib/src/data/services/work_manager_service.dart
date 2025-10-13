import 'package:injectable/injectable.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:developer' as developer;

const String kSyncTaskName = 'noteventure_background_sync';
const String kSyncTaskTag = 'noteventure_sync';

@lazySingleton
class WorkManagerService {
  bool _isInitialized = false;

  /// Initialize WorkManager with callback dispatcher
  Future<void> initialize({
    required Function() callbackDispatcher,
    bool enableDebugMode = false,
  }) async {
    if (_isInitialized) {
      developer.log('[WorkManagerService] Already initialized, skipping');
      return;
    }

    try {
      await Workmanager().initialize(
        callbackDispatcher, // ← Pass the callback function
        isInDebugMode: enableDebugMode,
      );

      _isInitialized = true;
      developer.log('[WorkManagerService] Initialized successfully');
    } catch (e, stackTrace) {
      developer.log('[WorkManagerService] Initialization failed: $e');
      developer.log('[WorkManagerService] Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Register periodic sync task
  Future<void> registerPeriodicSync({
    Duration syncFrequency = const Duration(minutes: 15),
  }) async {
    if (!_isInitialized) {
      throw StateError('WorkManager not initialized. Call initialize() first.');
    }

    try {
      await Workmanager().registerPeriodicTask(
        kSyncTaskName,
        kSyncTaskName,
        frequency: syncFrequency,
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresDeviceIdle: false,
          requiresStorageNotLow: false,
        ),
        existingWorkPolicy: ExistingWorkPolicy.replace,
        initialDelay: const Duration(minutes: 1),
        backoffPolicy: BackoffPolicy.exponential,
        backoffPolicyDelay: const Duration(minutes: 1),
        tag: kSyncTaskTag,
      );

      developer.log(
        '[WorkManagerService] Periodic sync registered (${syncFrequency.inMinutes} min)',
      );
    } catch (e, stackTrace) {
      developer.log(
        '[WorkManagerService] Failed to register periodic sync: $e',
      );
      developer.log('[WorkManagerService] Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Trigger immediate one-time sync
  Future<void> triggerImmediateSync() async {
    if (!_isInitialized) {
      throw StateError('WorkManager not initialized');
    }

    try {
      final taskId = 'immediate_sync_${DateTime.now().millisecondsSinceEpoch}';

      await Workmanager().registerOneOffTask(
        taskId,
        kSyncTaskName,
        initialDelay: const Duration(seconds: 1),
        constraints: Constraints(networkType: NetworkType.connected),
        existingWorkPolicy: ExistingWorkPolicy.append,
        tag: kSyncTaskTag,
      );

      developer.log('[WorkManagerService] Immediate sync triggered');
    } catch (e) {
      developer.log(
        '[WorkManagerService] Failed to trigger immediate sync: $e',
      );
      rethrow;
    }
  }

  /// Cancel all sync tasks
  Future<void> cancelAllSyncTasks() async {
    try {
      await Workmanager().cancelByTag(kSyncTaskTag);
      developer.log('[WorkManagerService] All sync tasks cancelled');
    } catch (e) {
      developer.log('[WorkManagerService] Failed to cancel tasks: $e');
      rethrow;
    }
  }

  /// Cancel only periodic sync
  Future<void> cancelPeriodicSync() async {
    try {
      await Workmanager().cancelByUniqueName(kSyncTaskName);
      developer.log('[WorkManagerService] Periodic sync cancelled');
    } catch (e) {
      developer.log('[WorkManagerService] Failed to cancel periodic sync: $e');
      rethrow;
    }
  }

  /// Check if WorkManager is initialized
  bool get isInitialized => _isInitialized;
}
