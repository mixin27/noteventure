import 'package:equatable/equatable.dart';

import '../../domain/entities/sync_log.dart';

sealed class SyncHistoryEvent extends Equatable {
  const SyncHistoryEvent();

  @override
  List<Object?> get props => [];
}

final class LoadSyncHistory extends SyncHistoryEvent {
  const LoadSyncHistory();
}

final class ClearSyncHistoryRequest extends SyncHistoryEvent {
  const ClearSyncHistoryRequest();
}

final class RefreshSyncHistory extends SyncHistoryEvent {
  const RefreshSyncHistory();
}

final class SyncHistoryUpdated extends SyncHistoryEvent {
  final List<SyncLog> logs;
  const SyncHistoryUpdated(this.logs);

  @override
  List<Object?> get props => [logs];
}
