import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/sync_repository.dart';
import '../../domain/usecases/get_last_sync_time.dart';
import '../../domain/usecases/pull_from_server.dart';
import '../../domain/usecases/push_to_server.dart';
import '../../domain/usecases/sync_data.dart';
import 'sync_event.dart';
import 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final SyncData syncData;
  final PullFromServer pullFromServer;
  final PushToServer pushToServer;
  final GetLastSyncTime getLastSyncTime;

  SyncBloc({
    required this.syncData,
    required this.pullFromServer,
    required this.pushToServer,
    required this.getLastSyncTime,
  }) : super(SyncInitial()) {
    on<SyncRequested>(_onSyncRequested);
    on<PullRequested>(_onPullRequested);
    on<PushRequested>(_onPushRequested);
    on<GetLastSyncRequested>(_onGetLastSyncRequested);
  }

  Future<void> _onSyncRequested(
    SyncRequested event,
    Emitter<SyncState> emit,
  ) async {
    emit(SyncInProgress());

    final result = await syncData();

    result.fold((failure) => emit(SyncError(failure.message)), (syncResult) {
      // Emit success event
      AppEventBus().emit(
        PointsChangedEvent(
          newBalance: 0, // Will be updated by points bloc
          change: 0,
          reason: 'sync_completed',
        ),
      );

      emit(SyncSuccess(syncResult));
    });
  }

  Future<void> _onPullRequested(
    PullRequested event,
    Emitter<SyncState> emit,
  ) async {
    emit(SyncInProgress());

    final result = await pullFromServer();

    result.fold(
      (failure) => emit(SyncError(failure.message)),
      (syncResult) => emit(SyncSuccess(syncResult)),
    );
  }

  Future<void> _onPushRequested(
    PushRequested event,
    Emitter<SyncState> emit,
  ) async {
    emit(SyncInProgress());

    final result = await pushToServer();

    result.fold((failure) => emit(SyncError(failure.message)), (synceAt) {
      final syncResult = SyncResult(
        notesSynced: 0,
        transactionsSynced: 0,
        progressSynced: false,
        conflictsFound: 0,
        syncedAt: synceAt,
      );
      emit(SyncSuccess(syncResult));
    });
  }

  Future<void> _onGetLastSyncRequested(
    GetLastSyncRequested event,
    Emitter<SyncState> emit,
  ) async {
    final result = await getLastSyncTime();

    result.fold(
      (failure) => emit(SyncError(failure.message)),
      (lastSync) => emit(LastSyncLoaded(lastSync)),
    );
  }
}
