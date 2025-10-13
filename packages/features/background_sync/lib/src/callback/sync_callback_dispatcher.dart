import 'package:workmanager/workmanager.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer' as developer;

import '../data/services/sync_executer.dart';

/// Top-level callback for WorkManager
/// MUST be top-level function
@pragma('vm:entry-point')
void syncCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    developer.log('═══════════════════════════════════════');
    developer.log('[BackgroundSync] Task: $task');
    developer.log('[BackgroundSync] Time: ${DateTime.now()}');
    developer.log('═══════════════════════════════════════');

    try {
      // Initialize background DI container
      final getIt = GetIt.asNewInstance();

      // Initialize sync executor
      final executor = SyncExecutor();
      await executor.initialize(getIt);

      // Perform sync
      final success = await executor.performSync(getIt);

      // Cleanup
      await executor.dispose(getIt);

      developer.log('[BackgroundSync] ✓ Task completed: $success');
      developer.log('═══════════════════════════════════════');

      return Future.value(success);
    } catch (e, stackTrace) {
      developer.log('[BackgroundSync] ❌ Task failed');
      developer.log('[BackgroundSync] Error: $e');
      developer.log('[BackgroundSync] Stack: $stackTrace');
      developer.log('═══════════════════════════════════════');

      return Future.value(false);
    }
  });
}
