import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/clear_sync_history.dart';
import '../../domain/usecases/get_sync_history.dart';
import '../../domain/usecases/watch_sync_history.dart';
import 'sync_history_event.dart';
import 'sync_history_state.dart';

class SyncHistoryBloc extends Bloc<SyncHistoryEvent, SyncHistoryState> {
  final GetSyncHistory getSyncHistory;
  final ClearSyncHistory clearSyncHistory;
  final WatchSyncHistory watchSyncHistory;

  late StreamSubscription _syncLogsSubscription;

  SyncHistoryBloc({
    required this.getSyncHistory,
    required this.clearSyncHistory,
    required this.watchSyncHistory,
  }) : super(SyncHistoryInitial()) {
    on<LoadSyncHistory>(_onLoadSyncHistory);
    on<ClearSyncHistoryRequest>(_onClearSyncHistory);
    on<RefreshSyncHistory>(_onRefreshSyncHistory);
    on<SyncHistoryUpdated>(_onSyncHistoryUpdated);

    // Watch for settings changes
    _syncLogsSubscription = watchSyncHistory().listen((logs) {
      if (!isClosed) {
        add(RefreshSyncHistory());
      }
    });
  }

  @override
  Future<void> close() {
    _syncLogsSubscription.cancel();
    return super.close();
  }

  Future<void> _onLoadSyncHistory(
    LoadSyncHistory event,
    Emitter<SyncHistoryState> emit,
  ) async {
    emit(SyncHistoryLoading());

    final result = await getSyncHistory();

    result.fold(
      (failure) => emit(SyncHistoryError(failure.message)),
      (syncLogs) => emit(SyncHistoryLoaded(syncLogs: syncLogs)),
    );
  }

  Future<void> _onClearSyncHistory(
    ClearSyncHistoryRequest event,
    Emitter<SyncHistoryState> emit,
  ) async {
    emit(SyncHistoryLoading());

    final result = await clearSyncHistory();

    result.fold(
      (failure) => emit(SyncHistoryError(failure.message)),
      (_) => emit(SyncHistoryLoaded(syncLogs: [])),
    );
  }

  Future<void> _onRefreshSyncHistory(
    RefreshSyncHistory event,
    Emitter<SyncHistoryState> emit,
  ) async {
    add(LoadSyncHistory());
  }

  Future<void> _onSyncHistoryUpdated(
    SyncHistoryUpdated event,
    Emitter<SyncHistoryState> emit,
  ) async {
    emit(SyncHistoryLoaded(syncLogs: event.logs));
  }
}
