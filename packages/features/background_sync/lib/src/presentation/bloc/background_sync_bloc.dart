import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/cancel_background_sync.dart';
import '../../domain/usecases/initialize_background_sync.dart';
import '../../domain/usecases/trigger_immediate_sync.dart';
import '../../domain/usecases/update_sync_frequency.dart';
import 'background_sync_event.dart';
import 'background_sync_state.dart';

@injectable
class BackgroundSyncBloc
    extends Bloc<BackgroundSyncEvent, BackgroundSyncState> {
  final InitializeBackgroundSync _initializeBackgroundSync;
  final TriggerImmediateSync _triggerImmediateSync;
  final CancelBackgroundSync _cancelBackgroundSync;
  final UpdateSyncFrequency _updateSyncFrequency;

  Duration _currentSyncFrequency = const Duration(minutes: 15);
  DateTime? _lastSyncTime;
  Timer? _syncCompleteTimer;

  BackgroundSyncBloc(
    this._initializeBackgroundSync,
    this._triggerImmediateSync,
    this._cancelBackgroundSync,
    this._updateSyncFrequency,
  ) : super(BackgroundSyncInitial()) {
    on<InitializeBackgroundSyncEvent>(_onInitialize);
    on<TriggerImmediateSyncEvent>(_onTriggerImmediate);
    on<EnableBackgroundSyncEvent>(_onEnable);
    on<DisableBackgroundSyncEvent>(_onDisable);
    on<UpdateSyncFrequencyEvent>(_onUpdateFrequency);
    on<SyncCompletedEvent>(_onSyncCompleted);
  }

  Future<void> _onInitialize(
    InitializeBackgroundSyncEvent event,
    Emitter<BackgroundSyncState> emit,
  ) async {
    emit(BackgroundSyncLoading());

    final result = await _initializeBackgroundSync(
      syncFrequency: event.syncFrequency,
      enableDebugMode: event.enableDebugMode,
    );

    result.fold((failure) => emit(BackgroundSyncError(failure.message)), (_) {
      _currentSyncFrequency = event.syncFrequency;
      emit(
        BackgroundSyncEnabled(
          syncFrequency: event.syncFrequency,
          lastSyncTime: _lastSyncTime,
        ),
      );
    });
  }

  Future<void> _onTriggerImmediate(
    TriggerImmediateSyncEvent event,
    Emitter<BackgroundSyncState> emit,
  ) async {
    // Show syncing state
    emit(BackgroundSyncTriggered());

    final result = await _triggerImmediateSync();

    result.fold(
      (failure) {
        emit(BackgroundSyncError(failure.message));
        // Return to enabled state after error
        Future.delayed(const Duration(seconds: 2), () {
          if (!isClosed) {
            add(SyncCompletedEvent(success: false));
          }
        });
      },
      (_) {
        // Wait for sync to complete (give it some time)
        // In a real app, you'd have a mechanism to detect actual completion
        _syncCompleteTimer?.cancel();
        _syncCompleteTimer = Timer(const Duration(seconds: 3), () {
          if (!isClosed) {
            add(SyncCompletedEvent(success: true));
          }
        });
      },
    );
  }

  Future<void> _onEnable(
    EnableBackgroundSyncEvent event,
    Emitter<BackgroundSyncState> emit,
  ) async {
    emit(BackgroundSyncLoading());

    final result = await _initializeBackgroundSync(
      syncFrequency: event.syncFrequency,
    );

    result.fold((failure) => emit(BackgroundSyncError(failure.message)), (_) {
      _currentSyncFrequency = event.syncFrequency;
      emit(
        BackgroundSyncEnabled(
          syncFrequency: event.syncFrequency,
          lastSyncTime: _lastSyncTime,
        ),
      );
    });
  }

  Future<void> _onDisable(
    DisableBackgroundSyncEvent event,
    Emitter<BackgroundSyncState> emit,
  ) async {
    emit(BackgroundSyncLoading());

    final result = await _cancelBackgroundSync();

    result.fold(
      (failure) => emit(BackgroundSyncError(failure.message)),
      (_) => emit(BackgroundSyncDisabled()),
    );
  }

  Future<void> _onUpdateFrequency(
    UpdateSyncFrequencyEvent event,
    Emitter<BackgroundSyncState> emit,
  ) async {
    final result = await _updateSyncFrequency(event.frequency);

    result.fold((failure) => emit(BackgroundSyncError(failure.message)), (_) {
      _currentSyncFrequency = event.frequency;
      emit(
        BackgroundSyncEnabled(
          syncFrequency: event.frequency,
          lastSyncTime: _lastSyncTime,
        ),
      );
    });
  }

  void _onSyncCompleted(
    SyncCompletedEvent event,
    Emitter<BackgroundSyncState> emit,
  ) {
    if (event.success) {
      _lastSyncTime = DateTime.now();
    }

    // Return to enabled state with updated last sync time
    emit(
      BackgroundSyncEnabled(
        syncFrequency: _currentSyncFrequency,
        lastSyncTime: _lastSyncTime,
      ),
    );
  }

  @override
  Future<void> close() {
    _syncCompleteTimer?.cancel();
    return super.close();
  }
}
