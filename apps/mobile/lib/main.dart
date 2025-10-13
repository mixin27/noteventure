import 'dart:developer' as developer;

import 'package:background_sync/background_sync.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';
import 'di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();

  // Initialize audio
  await AudioManager().initialize();

  // Initialize background sync
  developer.log('[App] Initializing background sync...');
  final initUseCase = getItBackgroundSync<InitializeBackgroundSync>();
  final result = await initUseCase(
    syncFrequency: const Duration(minutes: 15),
    enableDebugMode: true, // Set to false in production
  );

  result.fold(
    (failure) {
      developer.log(
        '[App] ⚠️  Background sync initialization failed: ${failure.message}',
      );
      // Continue anyway - app can work without background sync
    },
    (_) {
      developer.log('[App] ✓ Background sync initialized');
    },
  );

  // Setup BLoC observer for debugging
  Bloc.observer = AppBlocObserver();

  developer.log('[App] ✓ Launching app...');
  runApp(const NoteventureApp());
}
